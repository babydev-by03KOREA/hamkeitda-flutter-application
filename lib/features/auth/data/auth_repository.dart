import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../domain/user.dart';
import 'auth_api.dart';

class AuthRepository {
  final AuthApi api;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const _kToken = 'auth_token';

  AuthRepository(this.api);

  Future<AppUser> login(String email, String password) async {
    final data = await api.login(email, password);
    await _storage.write(key: _kToken, value: data['token'] as String?);
    return AppUser.fromJson(data);
  }

  Future<AppUser> signup(
    String nickname,
    String email,
    String password,
    String role,
  ) async {
    final data = await api.signup(
      nickname: nickname,
      email: email,
      password: password,
      role: role,
    );
    await _storage.write(key: _kToken, value: data['token'] as String?);
    return AppUser.fromJson(data);
  }

  Future<void> signOut() async {
    await _storage.delete(key: _kToken);
  }

  Future<String?> readToken() => _storage.read(key: _kToken);
}
