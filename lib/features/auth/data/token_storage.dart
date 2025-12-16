import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _kAccess = 'access_token';
  static const _kRefresh = 'refresh_token';

  final FlutterSecureStorage _s;
  TokenStorage(this._s);

  Future<String?> getAccess() => _s.read(key: _kAccess);
  Future<String?> getRefresh() => _s.read(key: _kRefresh);

  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _s.write(key: _kAccess, value: accessToken);
    await _s.write(key: _kRefresh, value: refreshToken);
  }

  Future<void> clear() async {
    await _s.delete(key: _kAccess);
    await _s.delete(key: _kRefresh);
  }
}