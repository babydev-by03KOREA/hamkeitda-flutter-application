import '../domain/admin_counsel_models.dart';
import 'admin_counsel_api.dart';

class AdminCounselRepository {
  final AdminCounselApi api;

  AdminCounselRepository(this.api);

  /// ✅ paging (Spring Page JSON)
  Future<CounselPageResponse> fetchPage({
    required int facilityId,
    required int page,
    required int size,
  }) async {
    final raw = await api.getCounsels(
      facilityId: facilityId,
      page: page,
      size: size,
    );

    final m = Map<String, dynamic>.from(raw as Map);
    return CounselPageResponse.fromJson(m);
  }

  /// ✅ (기존 코드 호환) 목록 전부 불러오기
  /// - 페이지네이션 API를 여러 번 호출해서 전체 합치는 방식
  Future<List<CounselNotification>> fetchCounsels({
    required int facilityId,
    int pageSize = 50,
  }) async {
    int page = 0;
    final items = <CounselNotification>[];

    while (true) {
      final res = await fetchPage(
        facilityId: facilityId,
        page: page,
        size: pageSize,
      );
      items.addAll(res.content);
      if (res.last) break;
      page++;
    }
    return items;
  }

  /// ✅ (기존 코드 호환) 단건 조회
  /// ⚠️ 백엔드에 단건 endpoint가 없어서 "임시"로 구현:
  ///   - 0페이지를 크게 가져와서 id로 찾음
  ///   - 데이터가 많아지면 반드시 백엔드에 단건 API 만들어야 함
  Future<CounselNotification> fetchCounselDetail(int counselId) async {
    // 임시로 크게 가져오기 (필요시 키우기)
    final res = await fetchPage(facilityId: 0, page: 0, size: 200);

    final found = res.content.where((e) => e.id == counselId).toList();
    if (found.isEmpty) {
      throw Exception('상담 신청서를 찾을 수 없습니다. id=$counselId');
    }
    return found.first;
  }
}
