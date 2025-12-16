import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hamkeitda_flutter/features/auth/domain/register_result.dart';
import 'package:hamkeitda_flutter/features/auth/domain/signup_response.dart';
import 'package:hamkeitda_flutter/features/auth/domain/token_pair.dart';
import '../domain/user.dart';
import 'auth_api.dart';

class AuthRepository {
  final AuthApi api;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';

  AuthRepository(this.api);

  UserRole mapRole(String raw) {
    switch (raw) {
      case 'ROLE_FACILITY':
        return UserRole.facility;
      case 'ROLE_USER':
        return UserRole.user;
      default:
        return UserRole.guest;
    }
  }

  Future<AppUser> login(String email, String password) async {
    try {
      final json = await api.login(email, password);
      final token = TokenPair.fromJson(json);

      await _storage.write(key: _kAccess, value: token.accessToken);
      await _storage.write(key: _kRefresh, value: token.refreshToken);

      return AppUser(
        id: token.userId,
        email: email,
        // 서버가 email 안주니까 일단 입력값으로 채움
        name: token.name,
        role: mapRole(token.role),
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
        facilityId: token.facilityId,
      );
    } on DioException catch (e) {
      throw Exception(_friendlyError(e));
    } catch (e) {
      debugPrint('❌ SIGNUP PARSE ERROR: $e');
      throw Exception('오류가 발생했어요. 잠시 후 다시 시도해주세요.');
    }
  }

  Future<RegisterResult> signup(
      String nickname,
      String email,
      String password,
      String role,
      ) async {
    try {
      final raw = await api.signup(
        nickname: nickname,
        email: email,
        password: password,
        role: role,
      );

      return RegisterResult.fromJson(raw);
    } on DioException catch (e) {
      throw Exception(_friendlyError(e));
    } catch (_) {
      throw Exception('오류가 발생했어요. 잠시 후 다시 시도해주세요.');
    }
  }

  Future<void> signOut() async {
    try {
      await _storage.delete(key: _kAccess);
      await _storage.delete(key: _kRefresh);
    } catch (e) {
      throw Exception('로그아웃 처리 중 오류가 발생했어요.');
    }
  }

  String _friendlyError(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return '네트워크가 느려요. 잠시 후 다시 시도해주세요.';
      case DioExceptionType.connectionError:
        return '서버에 연결할 수 없어요. 인터넷/서버 상태를 확인해주세요.';
      default:
        return '로그인에 실패했어요. 입력값을 확인해주세요.';
    }
  }

  Future<String?> readAccessToken() {
    return _storage.read(key: _kAccess);
  }

  Future<String?> readRefreshToken() {
    return _storage.read(key: _kRefresh);
  }
}
