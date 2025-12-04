import 'package:dio/dio.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_request.dart';

class CounselRepository {
  CounselRepository(this._dio);

  final Dio _dio;

  Future<void> submitCounsel({
    required int facilityId,
    required CounselRequest request,
  }) async {
    await _dio.post(
      '/api/facility/$facilityId/counsel',
      data: request.toJson(),
    );
  }
}