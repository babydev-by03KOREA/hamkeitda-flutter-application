import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/domain/register_result.dart';
import '../data/auth_repository.dart';
import '../data/auth_api.dart';
import '../domain/user.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(AuthApi()),
);

class AuthController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    // 앱 시작 시 토큰 존재 여부만 간단 확인
    final token = await ref.read(authRepositoryProvider).readAccessToken();
    return token != null
        ? const AppUser(
            id: 1,
            email: 'cached@email.com',
            name: 'name',
            role: UserRole.guest,
            accessToken: '',
            refreshToken: '',
          )
        : null;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .login(email, password);
      return user;
    });
  }

  Future<RegisterResult> signup({
    required String nickname,
    required String email,
    required String password,
    required String role,
  }) async {
    final result = await ref
        .read(authRepositoryProvider)
        .signup(nickname, email, password, role);

    return result;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(
  AuthController.new,
);
