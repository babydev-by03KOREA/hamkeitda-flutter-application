import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/dio_provider.dart';
import 'auth_api.dart';
import 'auth_repository.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final dio = ref.read(dioProvider);
  return AuthApi(dio: dio);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final api = ref.read(authApiProvider);
  return AuthRepository(api);
});