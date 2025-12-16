import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';
import '../domain/user.dart';

final currentUserProvider = Provider<AppUser?>((ref) {
  return ref.watch(authControllerProvider).valueOrNull;
});
