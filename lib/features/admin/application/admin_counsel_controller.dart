import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/data/admin_counsel_repository.dart';
import 'package:hamkeitda_flutter/features/admin/domain/admin_counsel.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_form_state.dart';

final adminCounselListProvider = StateNotifierProvider.family<
    AdminCounselListController,
    AsyncValue<List<AdminCounselSummary>>,
    int>((ref, facilityId) {
  final repo = ref.read(adminCounselRepositoryProvider);
  return AdminCounselListController(ref, repo, facilityId)..load();
});

class AdminCounselListController
    extends StateNotifier<AsyncValue<List<AdminCounselSummary>>> {
  AdminCounselListController(this.ref, this._repo, this.facilityId)
      : super(const AsyncLoading());

  final Ref ref;
  final AdminCounselRepository _repo;
  final int facilityId;

  Future<void> load() async {
    state = const AsyncLoading();
    try {
      final list = await _repo.fetchCounsels(facilityId: facilityId);
      state = AsyncData(list);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

/// 상세 조회용 Provider (선택된 신청서 보기)
final adminCounselDetailProvider = FutureProvider.family<
    CounselFormState, int>((ref, counselId) async {
  final repo = ref.read(adminCounselRepositoryProvider);
  final detail = await repo.fetchCounselDetail(counselId);
  // 서버 answersJson -> 우리 폼 상태로 변환
  return CounselFormState.fromJson(detail.answersJson);
});