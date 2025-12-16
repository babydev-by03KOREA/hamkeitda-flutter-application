import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/lib.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: API_BASE_URL,
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final repo = ref.read(authRepositoryProvider);
        final token = await repo.readAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ),
  );

  // 필요 시 로깅 인터셉터 추가
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  return dio;
});
