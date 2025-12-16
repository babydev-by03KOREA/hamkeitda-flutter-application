import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/domain/user.dart';
import 'package:hamkeitda_flutter/core/jwt_utils.dart';
import '../data/auth_repository.dart';
import '../data/auth_api.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(AuthApi()),
);

class AuthController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    final repo = ref.read(authRepositoryProvider);

    final at = await repo.readAccessToken();
    final rt = await repo.readRefreshToken();
    if (at == null || at.isEmpty) return null;

    final payload = decodeJwtPayload(at);
    if (payload == null) return null;

    // 서버 JWT: subject = userId, claim role = "ROLE_FACILITY" 이런 값
    final sub = payload['sub']?.toString();
    final roleStr = payload['role']?.toString();

    final userId = int.tryParse(sub ?? '');
    final role = _mapRole(roleStr);

    if (userId == null || role == null) return null;

    // 토큰도 state에 넣어서 앱 전체에서 참조 가능하게
    return AppUser(
      id: userId,
      email: '',
      // 지금 당장 필요 없으면 빈 값
      name: '',
      // 필요 없으면 빈 값
      role: role,
      accessToken: at,
      refreshToken: rt ?? '',
      facilityId: null, // 있으면 저장해서 복원해도 됨
    );
  }

  UserRole? _mapRole(String? v) {
    switch (v) {
      case 'ROLE_FACILITY':
        return UserRole.facility;
      case 'ROLE_USER':
        return UserRole.user;
      default:
        return UserRole.guest; // 혹은 null로 처리해도 됨
    }
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

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }

  Future<void> setFacilityId(int facilityId) async {
    final user = state.valueOrNull;
    if (user == null) return;

    state = AsyncData(user.copyWith(facilityId: facilityId));
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(
  AuthController.new,
);
