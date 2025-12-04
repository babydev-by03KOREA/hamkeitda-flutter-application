import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';
import 'package:hamkeitda_flutter/features/admin/domain/admin_counsel.dart';

final adminCounselRepositoryProvider =
Provider<AdminCounselRepository>((ref) {
  final dio = ref.read(dioProvider);
  return AdminCounselRepository(dio);
});

class AdminCounselRepository {
  final Dio _dio;
  AdminCounselRepository(this._dio);

  /// 상담 신청 목록 (Page 조회)
  Future<List<AdminCounselSummary>> fetchCounsels({
    required int facilityId,
    int page = 0,
    int size = 20,
  }) async {
    final res = await _dio.get(
      '/api/admin/facility/$facilityId/counsels',
      queryParameters: {'page': page, 'size': size},
    );

    // Spring Page 형태: { content: [...], totalElements: ..., ... }
    final content = res.data['content'] as List<dynamic>;
    return content
        .map((e) =>
        AdminCounselSummary.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
  }

  /// 상담 상세 (answers JSON 포함)
  Future<AdminCounselDetail> fetchCounselDetail(int counselId) async {
    final res = await _dio.get('/api/admin/counsels/$counselId');
    final raw = (res.data as Map).cast<String, dynamic>();

    // answers 가 String 으로 올 때
    final ansRaw = raw['answers'];
    Map<String, dynamic> answersMap;
    if (ansRaw is String) {
      answersMap = jsonDecode(ansRaw) as Map<String, dynamic>;
    } else {
      answersMap = (ansRaw as Map).cast<String, dynamic>();
    }

    return AdminCounselDetail(
      summary: AdminCounselSummary.fromJson(raw),
      answersJson: answersMap,
    );
  }
}