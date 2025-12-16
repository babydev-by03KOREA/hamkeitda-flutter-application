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

// 2. [수정] 어떤 유저 객체든 받을 수 있는 유연한 Mock Controller
class MockAuthController extends AuthController {
  final AppUser? mockUser;

  // 생성자에서 모킹할 유저(또는 null)를 받습니다.
  MockAuthController(this.mockUser);

  @override
  Future<AppUser?> build() async {
    // 생성자에서 받은 유저를 즉시 반환합니다.
    return mockUser;
  }
}

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
      title: 'Hamkeitda',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: () {
        final user = authState.valueOrNull;

        if (user != null) {
          if (user.role == UserRole.facility) {
            return const AdminDashboardScreen();
          }
          return const FacilityMapScreen();
        }

        return const ServiceTypeScreen();
      }(),
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
