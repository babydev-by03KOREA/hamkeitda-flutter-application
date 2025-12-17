import 'package:flutter/material.dart';

import '../domain/facility.dart';
import '../domain/facility_detail.dart';
import 'facility_api.dart';

class FacilityRepository {
  final FacilityApi api;

  FacilityRepository(this.api);

  dynamic _unwrap(dynamic res) {
    // 서버가 { data: ... }로 감싸는 경우 대응
    if (res is Map) {
      final data = res['data'];
      return data ?? res;
    }
    return res;
  }

  Future<List<Facility>> fetchNearby(
    double lat,
    double lng, {
    double radiusKm = 3,
  }) async {
    final res = await api.nearby(
      lat: lat,
      lng: lng,
      radius: (radiusKm * 1000).toInt(),
    );
    final raw = _unwrap(res);

    if (raw == null) return <Facility>[];
    if (raw is! List) throw Exception('nearby 응답이 List가 아닙니다: $raw');

    return raw
        .map((e) => Facility.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  Future<FacilityDetail> fetchDetail(int id) async {
    final raw = await api.detail(id); // Map
    final m = Map<String, dynamic>.from(raw as Map);

    String s(dynamic v) => (v ?? '').toString();

    final openTime = s(m['openTime']);
    final closedTime = s(m['closedTime']);

    final images =
        (m['images'] as List?)
            ?.map((e) => s((e as Map)['url']))
            .where((u) => u.trim().isNotEmpty)
            .toList() ??
        <String>[];

    final requiredDocs =
        (m['necessaryDocuments'] as List?)?.map((e) {
          final mm = Map<String, dynamic>.from(e as Map);
          return {
            'title': s(mm['documentName']),
            'note': s(mm['howToGet']), // ✅ null 금지
          };
        }).toList() ??
        <Map<String, dynamic>>[];

    final programs =
        (m['programs'] as List?)?.map((e) {
          final mm = Map<String, dynamic>.from(e as Map);
          return {
            'title': s(mm['programName']),
            'summary': s(mm['programDescription']), // ✅ null 금지
          };
        }).toList() ??
        <Map<String, dynamic>>[];

    final fees =
        (m['fees'] as List?)?.map((e) {
          final mm = Map<String, dynamic>.from(e as Map);
          final feeText = s(mm['feeText']);
          return {
            'item': s(mm['title']),
            'price': feeText.isNotEmpty
                ? feeText
                : '상담 필요', // ✅ required String 보호
            'note': feeText,
          };
        }).toList() ??
        <Map<String, dynamic>>[];

    final posts =
        (m['bbs'] as List?)?.map((e) {
          final mm = Map<String, dynamic>.from(e as Map);
          return {
            'id': (mm['id'] ?? '').toString(),
            'title': (mm['title'] ?? '').toString(),
            'preview': (mm['createdAt'] ?? '').toString(),
          };
        }).toList() ??
        <Map<String, dynamic>>[];

    final converted = <String, dynamic>{
      'id': int.tryParse(m['id'].toString()) ?? 0,
      'name': s(m['name']),
      'description': s(m['description']),
      'phone': s(m['phoneNumber']),
      'address': s(m['address']),
      'openHours': (openTime.isNotEmpty && closedTime.isNotEmpty)
          ? '$openTime - $closedTime'
          : '',
      'imageUrls': images,
      'imageUrl': images.isNotEmpty ? images.first : '',
      'requiredDocs': requiredDocs,
      'programs': programs,
      'fees': fees,
      'posts': posts,
    };

    debugPrint('converted = $converted');

    return FacilityDetail.fromJson(converted);
  }

  Future<void> submitConsult(
    String id,
    String name,
    String phone,
    String message,
  ) async {
    await api.submitConsult(id, name: name, phone: phone, message: message);
  }
}
