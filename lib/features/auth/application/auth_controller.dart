import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final token = await ref.read(authRepositoryProvider).readToken();
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

  Future<void> signup({
    required String nickname,
    required String email,
    required String password,
    required String role,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = await ref
          .read(authRepositoryProvider)
          .signup(nickname, email, password, role);
      return user;
    });
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
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
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(
  AuthController.new,
);
