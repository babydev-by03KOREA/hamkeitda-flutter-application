import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';
import 'package:hamkeitda_flutter/features/admin/data/admin_api.dart';
import 'package:hamkeitda_flutter/features/admin/data/admin_repository.dart';
import 'package:hamkeitda_flutter/features/admin/domain/admin_basic_state.dart';
import '../../auth/application/auth_provider.dart';
import '../../auth/application/auth_controller.dart';

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
      return const AdminBasicState(
        name: '',
        openTime: TimeOfDay(hour: 9, minute: 0),
        closedTime: TimeOfDay(hour: 18, minute: 0),
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
      final repo = ref.read(adminRepositoryProvider);
      final user = ref.read(currentUserProvider);
      final fid = user?.facilityId;

      if (fid == null) {
        // 1) 최초 생성
        final createdId = await repo.saveBasic(s);

        // 2) currentUser에 facilityId 반영 (중요)
        await ref
            .read(authControllerProvider.notifier)
            .setFacilityId(createdId);

        // 3) 서버 값 다시 불러와서 초기값 정합성 맞추기
        return await repo.getBasic(createdId);
      } else {
        // 수정
        await repo.updateBasic(fid, s);

        // 수정 후에도 서버 값 다시 불러오는 게 안전
        return await repo.getBasic(fid);
      }
    });
  }
}
