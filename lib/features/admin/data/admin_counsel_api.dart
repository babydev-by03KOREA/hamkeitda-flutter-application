import 'package:dio/dio.dart';

class AdminCounselApi {
  final Dio dio;
  AdminCounselApi(this.dio);

  /// 목록
  // Future<dynamic> getCounsels({required int facilityId}) async {
  //   final res = await dio.get('/api/admin/$facilityId/counsels');
  //   return res.data;
  // }

  /// 단건
  Future<dynamic> getCounselDetail(int counselId) async {
    final res = await dio.get('/admin/counsels/$counselId');
    return res.data;
  }

  /// GET /api/admin/{facilityId}/counsels?page=0&size=20
  Future<dynamic> getCounsels({
    required int facilityId,
    required int page,
    required int size,
  }) async {
    final res = await dio.get(
      '/admin/$facilityId/counsels',
      queryParameters: {'page': page, 'size': size},
    );
    return res.data;
  }
}