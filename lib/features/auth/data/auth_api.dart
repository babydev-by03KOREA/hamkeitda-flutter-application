import 'package:dio/dio.dart';
import 'package:hamkeitda_flutter/core/lib.dart';

class AuthApi {
  final Dio _dio;
  AuthApi({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: API_BASE_URL));

  Future<Map<String, dynamic>> login(String email, String password) async {
    // 실제 API 연결 시 아래 라인으로 교체
    // final res = await _dio.post('/auth/login', data: {'email': email, 'password': password});
    // return res.data as Map<String, dynamic>;

    await Future.delayed(const Duration(milliseconds: 800));
    if (email.endsWith('@test.com') && password == 'password123') {
      return {'id': 'u_1', 'email': email, 'name': '테스터', 'token': 'fake-jwt-token'};
    }
    throw DioException(requestOptions: RequestOptions(path: '/auth/login'), response: Response(requestOptions: RequestOptions(path: ''), statusCode: 401, data: {'message': '자격 증명 오류'}));
  }

  Future<Map<String, dynamic>> signup(String name, String email, String password) async {
    // final res = await _dio.post('/auth/signup', data: {'name': name, 'email': email, 'password': password});
    // return res.data as Map<String, dynamic>;

    await Future.delayed(const Duration(milliseconds: 900));
    return {'id': 'u_2', 'email': email, 'name': name, 'token': 'fake-jwt-token'};
  }
}