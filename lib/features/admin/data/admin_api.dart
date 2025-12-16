import 'package:dio/dio.dart';

class AdminApi {
  final Dio dio;
  AdminApi({required this.dio});

  Future<Map<String, dynamic>> getBasic(int facilityId) async {
    final res = await dio.get('/admin/$facilityId/basic');
    return (res.data as Map).cast<String, dynamic>();
  }

  Future<Map<String, dynamic>> saveBasic(Map<String, dynamic> body) async {
    final res = await dio.post('/admin/basic', data: body);
    return (res.data as Map).cast<String, dynamic>();
  }

  Future<Map<String, dynamic>> updateBasic(
      int facilityId,
      Map<String, dynamic> body,
      ) async {
    final res = await dio.put('/admin/$facilityId/basic', data: body);
    return (res.data as Map).cast<String, dynamic>();
  }
}