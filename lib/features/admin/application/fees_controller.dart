import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';
import '../data/admin_providers.dart';
import '../data/fees_repository.dart';
import '../domain/fee.dart';

final feesRepoProvider = Provider<FeesRepository>((ref) {
  final api = ref.read(adminApiProvider);
  return FeesRepository(api);
});

final feesProvider = AsyncNotifierProvider<FeesController, List<Fee>>(
  FeesController.new,
);

class FeesController extends AsyncNotifier<List<Fee>> {
  @override
  Future<List<Fee>> build() async {
    final fid = ref.watch(
      authControllerProvider.select((a) => a.valueOrNull?.facilityId),
    );
    if (fid == null) return <Fee>[];

    final repo = ref.read(feesRepoProvider);
    return repo.fetchFees(fid);
  }

  Future<void> add({required String title, required String feeText}) async {
    final fid = ref.read(authControllerProvider).valueOrNull?.facilityId;
    if (fid == null) throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(feesRepoProvider);
      await repo.createFee(facilityId: fid, title: title, feeText: feeText);
      return repo.fetchFees(fid);
    });
  }

  Future<void> remove(int feeId) async {
    final fid = ref.read(authControllerProvider).valueOrNull?.facilityId;
    if (fid == null) throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(feesRepoProvider);
      await repo.deleteFee(facilityId: fid, feeId: feeId);
      return repo.fetchFees(fid);
    });
  }
}
