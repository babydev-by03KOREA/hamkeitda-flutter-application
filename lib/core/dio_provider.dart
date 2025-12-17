import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/lib.dart';
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
    if (rt == null || rt.isEmpty) return false;

    final res = await refreshDio.post(
      '/api/auth/refresh',
      options: Options(headers: {'Authorization': 'Bearer $rt'}),
    );

    final body = res.data as Map<String, dynamic>;
    final data = (body['data'] as Map<String, dynamic>);

    final newAccess = data['accessToken'] as String?;
    final newRefresh = data['refreshToken'] as String?;

    if (newAccess == null || newAccess.isEmpty) return false;
    if (newRefresh == null || newRefresh.isEmpty) return false;

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
        // refresh는 RT로 따로 보낼 거라서 여기서 건드리지 않기
        final isRefresh = options.path.contains('/api/auth/refresh');
        if (!isRefresh) {
          final at = await tokenStorage.getAccess();
          if (at != null && at.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $at';
          }
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        final status = e.response?.statusCode;
        final isRefreshCall = e.requestOptions.path.contains(
          '/api/auth/refresh',
        );

        if (status == 401 && !isRefreshCall) {
          // refresh 시도
          if (!isRefreshing) {
            isRefreshing = true;
            refreshFuture = tryRefreshToken().whenComplete(
              () => isRefreshing = false,
            );
          }

          final ok = await refreshFuture!;
          if (!ok) return handler.next(e);

          final newAccess = await tokenStorage.getAccess();
          if (newAccess == null || newAccess.isEmpty) return handler.next(e);

          final req = e.requestOptions;

          try {
            final res = await dio.request(
              req.path,
              data: req.data,
              queryParameters: req.queryParameters,
              options: Options(
                method: req.method,
                headers: {
                  ...req.headers,
                  'Authorization': 'Bearer $newAccess',
                },
                contentType: req.contentType,
                responseType: req.responseType,
              ),
            );
            return handler.resolve(res);
          } catch (_) {
            return handler.next(e);
          }
        }

        return handler.next(e);
      },
    ),
  );

  return dio;
});
