// features/facility/application/facility_detail_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:hamkeitda_flutter/core/dio_provider.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_request.dart';
import 'package:hamkeitda_flutter/features/facility/application/facility_controller.dart'; // facilityRepositoryProvider
import '../domain/facility_detail.dart';

/// ✅ 상세 조회용 Provider (facilityId를 파라미터로 받는 Family)
final facilityDetailControllerProvider =
    AsyncNotifierProviderFamily<FacilityDetailController, FacilityDetail, int>(
      FacilityDetailController.new,
    );

/// ✅ FamilyAsyncNotifier 로 바꿔야 build(int id)가 정상 override 됩니다.
class FacilityDetailController
    extends FamilyAsyncNotifier<FacilityDetail, int> {
  @override
  Future<FacilityDetail> build(int facilityId) async {
    final repo = ref.read(facilityRepositoryProvider);

    debugPrint('📌 FacilityDetailController.build(facilityId=$facilityId)');

    // repo.fetchDetail(int id) 형태로 맞춰둔 버전
    return repo.fetchDetail(facilityId);
  }

  /// ✅ 상담 신청 (POST /api/facility/{id}/counsel)
  Future<void> submitConsult({
    required int facilityId,
    required CounselRequest req,
  }) async {
    try {
      final dio = ref.read(dioProvider);

      await dio.post('/facility/$facilityId/counsel', data: req.toJson());

      debugPrint('✅ 상담 신청 성공 (facilityId=$facilityId)');
    } on DioException catch (e) {
      debugPrint(
        '❌ 상담 신청 오류: ${e.requestOptions.uri}\n'
        '❌ STATUS: ${e.response?.statusCode}\n'
        '❌ BODY: ${e.response?.data}\n'
        '❌ MSG: ${e.message}',
      );
      rethrow;
    } catch (e) {
      debugPrint('❌ 상담 신청 알 수 없는 오류: $e');
      rethrow;
    }
  }

  /// (옵션) 상세 새로고침 헬퍼
  Future<void> refresh(int facilityId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build(facilityId));
  }
}
