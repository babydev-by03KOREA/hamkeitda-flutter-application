import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_provider.dart';
import 'package:hamkeitda_flutter/features/auth/domain/user.dart' show UserRole;

class AdminGuard extends ConsumerWidget {
  static const route = '/admin';
  final Widget child;
  const AdminGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    if (user == null) {
      // 미로그인 → 로그인 화면으로
      Future.microtask(() => Navigator.pushReplacementNamed(context, '/auth'));
      return const SizedBox.shrink();
    }
    if (user.role != UserRole.facilityAdmin && user.role != UserRole.superAdmin) {
      // 권한 없음
      return const Scaffold(
        body: Center(child: Text('접근 권한이 없습니다. 관리자에게 문의하세요.')),
      );
    }
    return child;
  }
}