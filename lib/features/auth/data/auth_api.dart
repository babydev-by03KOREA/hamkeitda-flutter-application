import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hamkeitda_flutter/core/lib.dart';

class AuthApi {
  final Dio _dio;

  AuthApi({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(baseUrl: API_BASE_URL, contentType: 'application/json'),
          );

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final res = await _dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      debugPrint('✅ LOGIN OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return (res.data as Map<String, dynamic>)['data'] as Map<String, dynamic>;
    } on DioException catch (e) {
      debugPrint('❌ LOGIN FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signup({
    required String nickname,
    required String email,
    required String password,
    required String role
  }) async {
    try {
      final res = await _dio.post(
        '/auth/register',
        data: {
          'nickname': nickname,
          'email': email,
          'password': password,
          'role': role,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      debugPrint('✅ JOIN OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return (res.data as Map<String, dynamic>)['data']['user'];
    } on DioException catch (e) {
      debugPrint('❌ JOIN FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }
}
