import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/domain/user.dart';

import '../data/auth_providers.dart';


final authControllerProvider =
AsyncNotifierProvider<AuthController, AppUser?>(AuthController.new);

class AuthController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    return ref.read(authRepositoryProvider).restoreSession();
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(authRepositoryProvider)
          .login(email, password);
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