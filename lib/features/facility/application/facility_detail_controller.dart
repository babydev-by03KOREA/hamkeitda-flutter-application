import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';
import 'package:hamkeitda_flutter/core/lib.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_request.dart';
import 'package:hamkeitda_flutter/features/facility/domain/fee_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/post_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/program_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/required_doc.dart';
import '../domain/facility_detail.dart';

final facilityDetailControllerProvider =
    StateNotifierProvider<FacilityDetailController, AsyncValue<FacilityDetail>>(
      (ref) => FacilityDetailController(ref),
    );

class FacilityDetailController
    extends StateNotifier<AsyncValue<FacilityDetail>> {
  FacilityDetailController(this.ref) : super(const AsyncLoading());

  final Ref ref;
  String? _id;

  void setId(String id) {
    _id = id;
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    if (_id == null) return;
    state = const AsyncLoading();
    return;

    try {
      final dio = ref.read(dioProvider);
      final res = await dio.get('/api/facility/$_id');
      // 응답이 Map이 아닐 수도 있으니 안전 캐스팅
      final data = (res.data as Map).cast<String, dynamic>();
      state = AsyncData(FacilityDetail.fromJson(data));
    } on DioException catch (e, st) {
      state = AsyncError('네트워크 오류: ${e.message}', st);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> submitConsult({
    required CounselRequest req,
  }) async {
    if (_id == null) return;

    try {
      final dio = ref.read(dioProvider);

      // 백엔드: POST /api/facility/{id}/counsel
      await dio.post(
        '/api/facility/$_id/counsel',
        data: req.toJson(),
      );

      debugPrint('상담 신청 성공');
    } on DioException catch (e) {
      debugPrint('상담 신청 오류: ${e.response?.statusCode} ${e.message}');
      rethrow; // 화면 쪽에서 스낵바 띄우고 싶으면 rethrow 하는 것도 가능
    } catch (e) {
      debugPrint('상담 신청 알 수 없는 오류: $e');
      rethrow;
    }
  }

  // ── MOCK DETAIL ──
  FacilityDetail _mockDetail(String id) => FacilityDetail(
    id: id,
    name: '장애인복지센터',
    description: '사람과 보통의 일상을 지역사회에서 온전한 삶으로 잇다.',
    phone: '02-4567-8901',
    openHours: '09:00 - 20:00',
    address: '울산 남구 어딘가로3',
    imageUrl: null,
    requiredDocs: const [
      RequiredDoc(title: '보호자신분증', note: '보호자 신분증 실물을 들고오시면 됩니다.'),
      RequiredDoc(title: '장애인복지카드'),
    ],
    programs: const [
      ProgramInfo(title: '낮 프로그램', summary: '기초 학습 및 공예'),
      ProgramInfo(title: '자립훈련', summary: '생활훈련, 사회성 개발'),
    ],
    fees: const [
      FeeInfo(item: '기본 이용료', price: '월 30,000원', note: '재료비 별도'),
      FeeInfo(item: '상담비', price: '무료'),
    ],
    posts: const [
      PostInfo(id: 'p1', title: '6월 프로그램 안내', preview: '이번 달 일정 공지합니다.'),
    ],
  );
}
