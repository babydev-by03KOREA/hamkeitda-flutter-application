import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/lib.dart';
import '../../../core/dio_provider.dart';

abstract class AdminApi {
  Future<Map<String, dynamic>> getFacilityForAdmin(String facilityId);
  Future<void> updateBasic(String facilityId, Map<String, dynamic> body);
}

final adminApiProvider = Provider<AdminApi>((ref) {
  if (USE_MOCK) return MockAdminApi();
  return RealAdminApi(ref.read(dioProvider));
});

class RealAdminApi implements AdminApi {
  final Dio _dio;
  RealAdminApi(this._dio);

  @override
  Future<Map<String, dynamic>> getFacilityForAdmin(String id) async {
    final res = await _dio.get('/api/admin/facility/$id');
    return (res.data as Map).cast<String, dynamic>();
  }

  @override
  Future<void> updateBasic(String id, Map<String, dynamic> body) async {
    await _dio.put('/api/admin/facility/$id', data: body);
  }
}

class MockAdminApi implements AdminApi {
  @override
  Future<Map<String, dynamic>> getFacilityForAdmin(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return {
      'name': '희망복지센터',
      'openHours': '09:00 - 18:00',
      'phone': '02-1234-5678',
      'address': '서울시 중구 세종대로 110',
      'description': '전문적인 복지 서비스를 제공하는 시설입니다.',
      'imageUrl': null,
    };
  }

  @override
  Future<void> updateBasic(String id, Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    // noop: 성공 가정
  }
}
