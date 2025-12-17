import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/dio_provider.dart'; // ✅ 너 프로젝트 dioProvider 경로로 맞춰

final facilityApiProvider = Provider<FacilityApi>((ref) {
  final dio = ref.read(dioProvider);
  return FacilityApi(dio: dio);
});

class FacilityApi {
  final Dio dio;

  FacilityApi({required this.dio});

  /// GET /api/facility/nearby?lat=..&lng=..&radius=1000
  Future<dynamic> nearby({
    required double lat,
    required double lng,
    required int radius,
  }) async {
    try {
      final res = await dio.get(
        '/facility/nearby',
        queryParameters: {'lat': lat, 'lng': lng, 'radius': radius},
        options: Options(responseType: ResponseType.plain),
      );

      final text = res.data?.toString() ?? '';
      debugPrint('🟨 nearby raw length=${text.length}');
      debugPrint(
        '🟨 nearby raw head=${text.substring(0, text.length > 500 ? 500 : text.length)}',
      );

      // 서버가 JSON을 문자열로 준다면 여기서 파싱
      return jsonDecode(text);
    } on DioException catch (e, st) {
      debugPrint('❌ nearby FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ type: ${e.type}');
      debugPrint('❌ message: ${e.message}');
      debugPrint(
        '❌ error: ${e.error}',
      ); // << 이게 핵심 (SocketException/Timeout 등 뜸)
      debugPrint('❌ stack: $st');
      debugPrint('❌ response: ${e.response?.statusCode} / ${e.response?.data}');
      rethrow;
    }
  }

  /// GET /api/facility/{id}
  Future<dynamic> detail(int id) async {
    try {
      final res = await dio.get('/facility/$id');

      debugPrint('✅ detail OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');

      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ detail FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  /// POST /api/facility/{id}/counsel
  /// body: { answers, applicantName, applicantPhone }
  Future<dynamic> submitConsult(
    String id, {
    required String name,
    required String phone,
    required String message,
  }) async {
    try {
      final res = await dio.post(
        '/facility/$id/counsel',
        data: {
          'answers': message,
          'applicantName': name,
          'applicantPhone': phone.isEmpty ? null : phone,
        },
      );
      debugPrint('✅ submitConsult OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');

      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ submitConsult FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  /// (옵션) GET /api/facility/{id}/bbs?page=0&size=10
  Future<dynamic> getBbs(String id, {int page = 0, int size = 10}) async {
    try {
      final res = await dio.get(
        '/facility/$id/bbs',
        queryParameters: {'page': page, 'size': size},
      );
      debugPrint('✅ getBbs OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');

      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ getBbs FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }
}
