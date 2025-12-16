import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/lib.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';
import 'package:hamkeitda_flutter/features/auth/data/auth_providers.dart';
import 'package:hamkeitda_flutter/main.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final tokenStorage = ref.read(tokenStorageProvider);

  // refresh용 dio (인터셉터 안 타게 별도)
  final refreshDio = Dio(
    BaseOptions(
      baseUrl: 'http://211.188.48.147:8080',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  bool isRefreshing = false;
  Future<bool>? refreshFuture;

  Future<bool> tryRefreshToken() async {
    final rt = await tokenStorage.getRefresh();
    debugPrint('[REFRESH] hasRT=${rt != null && rt.isNotEmpty}');
    if (rt == null || rt.isEmpty) return false;

    final res = await refreshDio.post(
      '/api/auth/refresh',
      data: {'refreshToken': rt},
    );

    final data = (res.data as Map).cast<String, dynamic>();
    final newAccess = data['accessToken'] as String?;
    final newRefresh = (data['refreshToken'] as String?) ?? rt;

    if (newAccess == null || newAccess.isEmpty) return false;

    await tokenStorage.save(accessToken: newAccess, refreshToken: newRefresh);
    return true;
  }

  void forceLogoutMoveToServiceType() async {
    await tokenStorage.clear();
    rootNavKey.currentState?.pushNamedAndRemoveUntil(
      '/service-type',
      (route) => false,
    );
  }

  dio.interceptors.add(
    QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        // access token 자동 첨부
        final at = await tokenStorage.getAccess();
        debugPrint(
          '[REQ] ${options.uri}  hasAT=${at != null && at.isNotEmpty}',
        );
        if (at != null && at.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $at';
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        debugPrint(
          '[ERR] ${e.requestOptions.uri} status=${e.response?.statusCode}',
        );
        final status = e.response?.statusCode;

        // 401이면 refresh 시도
        if (status == 401) {
          final path = e.requestOptions.path;

          // refresh 자체가 401이면 끝
          if (path.contains('/api/auth/refresh')) {
            forceLogoutMoveToServiceType();
            return handler.next(e);
          }

          // refresh 동시성 제어
          if (!isRefreshing) {
            isRefreshing = true;
            refreshFuture = tryRefreshToken().whenComplete(() {
              isRefreshing = false;
            });
          }

          final ok = await refreshFuture!;
          if (!ok) {
            forceLogoutMoveToServiceType();
            return handler.next(e);
          }

          // refresh 성공 → 원 요청 재시도
          final newAccess = await tokenStorage.getAccess();
          final retryOptions = e.requestOptions;

          retryOptions.headers['Authorization'] = 'Bearer $newAccess';

          try {
            final response = await dio.fetch(retryOptions);
            return handler.resolve(response);
          } catch (err) {
            // 재시도도 실패하면 로그아웃
            forceLogoutMoveToServiceType();
            return handler.next(e);
          }
        }

        dio.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );

        return handler.next(e);
      },
    ),
  );

  return dio;
});
