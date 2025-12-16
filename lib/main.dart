import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/lib.dart';
import 'package:hamkeitda_flutter/features/admin/presentation/admin_dashboard_screen.dart';
import 'package:hamkeitda_flutter/features/admin/presentation/admin_guard.dart';
import 'package:hamkeitda_flutter/features/auth/domain/user.dart';
import 'package:hamkeitda_flutter/features/facility/presentation/facility_detail_screen.dart';
import 'core/theme.dart';
import 'features/auth/application/auth_provider.dart';
import 'features/auth/presentation/auth_screen.dart';

// 1. IMPORT YOUR REAL CONTROLLER
import 'features/auth/application/auth_controller.dart';
import 'features/auth/presentation/service_type_screen.dart';
import 'features/facility/presentation/facility_map_screen.dart';

final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: const App()));
}

// App 위젯은 수정할 필요가 없습니다.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return MaterialApp(
      navigatorKey: rootNavKey,
      title: 'Hamkeitda',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: authState.when(
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(body: Center(child: Text('오류: $e'))),
        data: (user) {
          if (user == null) return const ServiceTypeScreen();

          switch (user.role) {
            case UserRole.facility:
              return const AdminDashboardScreen();
            case UserRole.user:
              return const FacilityMapScreen();
            default:
              return const ServiceTypeScreen();
          }
        },
      ),
      routes: {
        ServiceTypeScreen.route: (_) => const ServiceTypeScreen(),
        AuthScreen.route: (_) => const AuthScreen(),
        FacilityMapScreen.route: (_) => const FacilityMapScreen(),
        FacilityDetailScreen.route: (ctx) {
          final id = ModalRoute.of(ctx)!.settings.arguments as String;
          return FacilityDetailScreen(id: id);
        },
        AdminGuard.route: (ctx) =>
            const AdminGuard(child: AdminDashboardScreen()),
      },
    );
  }
}
