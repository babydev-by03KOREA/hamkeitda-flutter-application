import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';
import 'package:hamkeitda_flutter/features/admin/data/admin_api.dart';
import 'package:hamkeitda_flutter/features/admin/data/admin_repository.dart';
import 'package:hamkeitda_flutter/features/admin/domain/admin_basic_state.dart';
import '../../auth/application/auth_provider.dart';

final adminApiProvider = Provider<AdminApi>((ref) {
  final dio = ref.read(dioProvider);
  return AdminApi(dio: dio);
});

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepository(ref.read(adminApiProvider));
});

final adminBasicProvider =
    AsyncNotifierProvider<AdminBasicController, AdminBasicState>(
      AdminBasicController.new,
    );

class AdminBasicController extends AsyncNotifier<AdminBasicState> {
  @override
  Future<AdminBasicState> build() async {
    final user = ref.watch(currentUserProvider);

    final fid = user?.facilityId;
    if (fid == null) {
      // 시설 등록 전이면 Empty Form
      return const AdminBasicState(
        name: '',
        openHours: '',
        phone: '',
        address: '',
        description: '',
        imageUrl: null,
      );
    }

    final repo = ref.read(adminRepositoryProvider);
    return repo.getBasic(fid);
  }

  Future<void> save(AdminBasicState s) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final user = ref.read(currentUserProvider);
      final repo = ref.read(adminRepositoryProvider);

      final fid = user?.facilityId;
      if (fid == null) {
        // 아직 facilityId가 없으면 "생성" API로
        await repo.saveBasic(s);
      } else {
        // 있으면 "수정"
        await repo.updateBasic(fid, s);
      }

      // 저장 후 화면 갱신
      return s;
    });
  }
}
