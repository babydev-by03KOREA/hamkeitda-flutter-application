import 'package:flutter/material.dart';
import '../domain/fee.dart';
import 'admin_api.dart';

class FeesRepository {
  final AdminApi api;
  FeesRepository(this.api);

  Future<List<Fee>> fetchFees(int facilityId) async {
    final res = await api.getFees(facilityId);

    final raw = (res is Map && res['data'] != null) ? res['data'] : res;
    if (raw == null) return <Fee>[];
    if (raw is! List) throw Exception('List 아님: $raw');

    return raw
        .map((e) => Fee.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<int> createFee({
    required int facilityId,
    required String title,
    required String feeText,
  }) async {
    // 서버 req: FeeCreateRequest(title, feeText, sortOrder?)
    final json = await api.addFee(facilityId, {
      'title': title,
      'feeText': feeText,
    });

    final data = (json is Map && json['data'] is Map) ? json['data'] as Map : json;
    return (data['id'] as num).toInt();
  }

  Future<void> deleteFee({
    required int facilityId,
    required int feeId,
  }) async {
    await api.deleteFee(facilityId, feeId);
  }
}