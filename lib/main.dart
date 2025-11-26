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

  // 3. [수정] --dart-define 플래그로 'MOCK_ROLE' 값을 읽어옵니다.
  const mockRole = String.fromEnvironment('MOCK_ROLE');

  final overrides = <Override>[];
  AppUser? userToMock; // 모킹할 유저 (null이면 guest)
  bool useMock = false; // 모킹 사용 여부

  // 4. [수정] MOCK_ROLE 값에 따라 모킹할 유저 데이터를 결정합니다.
  switch (mockRole) {
    case 'admin':
    case 'facilityAdmin':
    case 'superAdmin':
      userToMock = const AppUser(
        id: 'admin-1',
        email: 'admin@test.com',
        name: '관리자 (모드)',
        role: UserRole.superAdmin,
        facilityId: 'f-admin',
      );
      useMock = true;
      break;
    case 'member':
      userToMock = const AppUser(
        id: 'member-1',
        email: 'member@test.com',
        name: '일반회원 (모드)',
        role: UserRole.member,
        facilityId: 'f-member', // 필요시 수정
      );
      useMock = true;
      break;
    case 'guest':
      userToMock = null; // guest는 로그인하지 않은 상태(null)로 설정
      useMock = true;
      break;
    default:
    // MOCK_ROLE 값이 없거나 인식할 수 없으면 모킹을 사용하지 않습니다.
      useMock = false;
  }

  // 5. [수정] 모킹을 사용해야 할 경우에만 override합니다.
  if (useMock) {
    overrides.add(
      authControllerProvider.overrideWith(
        // MockAuthController에 위에서 결정된 userToMock을 주입
            () => MockAuthController(userToMock),
      ),
    );
  }

  runApp(ProviderScope(overrides: overrides, child: const App()));
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
          if (user.role == UserRole.superAdmin ||
              user.role == UserRole.facilityAdmin) {
            return const AdminDashboardScreen();
          }
          // [수정] MOCK_ROLE=member 일 때 FacilityMapScreen으로 갑니다.
          return const FacilityMapScreen();
        }

        // [수정] MOCK_ROLE=guest 일 때 ServiceTypeScreen으로 갑니다.
        return const ServiceTypeScreen();
      }(),
      routes: {
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
