import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AdminApi {
  final Dio dio;

  AdminApi({required this.dio});

  Future<Map<String, dynamic>> getBasic(int facilityId) async {
    try {
      final res = await dio.get('/admin/$facilityId/basic');
      debugPrint('✅ getBasic OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return (res.data as Map).cast<String, dynamic>();
    } on DioException catch (e) {
      debugPrint('❌ getBasic FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> saveBasic(Map<String, dynamic> body) async {
    try {
      final res = await dio.post('/admin/basic', data: body);
      debugPrint('✅ saveBasic OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return (res.data as Map).cast<String, dynamic>();
    } on DioException catch (e) {
      debugPrint('❌ saveBasic FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateBasic(
    int facilityId,
    Map<String, dynamic> body,
  ) async {
    try {
      final res = await dio.put('/admin/$facilityId/basic', data: body);
      debugPrint('✅ updateBasic OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return (res.data as Map).cast<String, dynamic>();
    } on DioException catch (e) {
      debugPrint('❌ updateBasic FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<dynamic> uploadFacilityImage({
    required int facilityId,
    required File file,
    bool isPrimary = false,
    String? caption,
  }) async {
    try {
      final form = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
        'isPrimary': isPrimary,
        if (caption != null) 'caption': caption,
      });

      final res = await dio.post(
        '/admin/$facilityId/images',
        data: form,
        options: Options(contentType: 'multipart/form-data'),
      );

      debugPrint('✅ uploadFacilityImage OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ uploadFacilityImage FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  /*
  * 필요 서류 불러오기, 삭제, 추가
  * */
  Future<dynamic> getDocuments(int facilityId) async {
    try {
      final res = await dio.get('/admin/$facilityId/documents');
      debugPrint('✅ getDocuments OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ getDocuments FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<dynamic> addDocument(int facilityId, Map<String, dynamic> body) async {
    try {
      final res = await dio.post('/admin/$facilityId/documents', data: body);
      debugPrint('✅ addDocument OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ addDocument FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<void> deleteDocument(int facilityId, int documentId) async {
    try {
      final res = await dio.delete('/admin/$facilityId/documents/$documentId');
      debugPrint('✅ deleteDocument OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
    } on DioException catch (e) {
      debugPrint('❌ deleteDocument FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  /*
  * 프로그램 불러오기, 삭제, 추가
  * */
  Future<dynamic> getPrograms(int facilityId) async {
    try {
      final res = await dio.get('/admin/$facilityId/programs');
      debugPrint('✅ getPrograms OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ getPrograms FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<dynamic> addProgram(int facilityId, Map<String, dynamic> body) async {
    try {
      final res = await dio.post('/admin/$facilityId/programs', data: body);
      debugPrint('✅ addProgram OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ addProgram FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  Future<void> deleteProgram(int facilityId, int programId) async {
    try {
      final res = await dio.delete('/admin/$facilityId/programs/$programId');
      debugPrint('✅ deleteProgram OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
    } on DioException catch (e) {
      debugPrint('❌ deleteProgram FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  // GET /api/admin/{facilityId}/fees
  Future<dynamic> getFees(int facilityId) async {
    try {
      final res = await dio.get('/admin/$facilityId/fees');
      debugPrint('✅ getFees OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ getFees FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  // POST /api/admin/{facilityId}/fees
  Future<dynamic> addFee(int facilityId, Map<String, dynamic> body) async {
    try {
      final res = await dio.post('/admin/$facilityId/fees', data: body);
      debugPrint('✅ addFee OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
      return res.data;
    } on DioException catch (e) {
      debugPrint('❌ addFee FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  // DELETE /api/admin/{facilityId}/fees/{feeId}
  Future<void> deleteFee(int facilityId, int feeId) async {
    try {
      final res = await dio.delete('/admin/$facilityId/fees/$feeId');
      debugPrint('✅ deleteFee OK: ${res.requestOptions.uri}');
      debugPrint('✅ BODY: ${res.data}');
    } on DioException catch (e) {
      debugPrint('❌ deleteFee FAIL: ${e.requestOptions.uri}');
      debugPrint('❌ STATUS: ${e.response?.statusCode}');
      debugPrint('❌ BODY: ${e.response?.data}');
      debugPrint('❌ MSG: ${e.message}');
      rethrow;
    }
  }

  // GET /api/admin/{facilityId}/bbs
  Future<dynamic> getBbs(int facilityId, {int page = 0, int size = 20}) async {
    try {
      final res = await dio.get(
        '/admin/$facilityId/bbs',
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

  Future<dynamic> createBbs(int facilityId, Map<String, dynamic> body) async {
    final res = await dio.post('/admin/$facilityId/bbs', data: body);
    debugPrint('✅ createBbs OK: ${res.requestOptions.uri}');
    debugPrint('✅ BODY: ${res.data}');
    return res.data;
  }

  Future<dynamic> uploadBbsImage({
    required int facilityId,
    required int bbsId,
    required File file,
    bool isPrimary = false,
    String? caption,
  }) async {
    final form = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
      'isPrimary': isPrimary,
      if (caption != null) 'caption': caption,
    });

    final res = await dio.post(
      '/admin/$facilityId/bbs/$bbsId/images',
      data: form,
      options: Options(contentType: 'multipart/form-data'),
    );

    debugPrint('✅ uploadBbsImage OK: ${res.requestOptions.uri}');
    debugPrint('✅ BODY: ${res.data}');
    return res.data;
  }
}
