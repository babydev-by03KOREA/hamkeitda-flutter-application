import 'package:flutter/cupertino.dart';

import '../domain/program.dart';
import 'admin_api.dart';

class ProgramsRepository {
  final AdminApi api;

  ProgramsRepository(this.api);

  dynamic unwrapData(dynamic res) {
    if (res is Map<String, dynamic>) {
      return res['data'] ?? res;
    }
    return res;
  }

  Future<List<Program>> fetchPrograms(int facilityId) async {
    final res = await api.getPrograms(facilityId);

    if (res == null) return <Program>[];

    final dynamic raw = (res is Map) ? (res['data'] ?? res) : res;

    if (raw is! List) return <Program>[];

    return raw
        .map((e) => Program.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<int> createProgram({
    required int facilityId,
    required String name,
    String? description,
  }) async {
    final json = await api.addProgram(facilityId, {
      'programName': name,
      'programDescription': description,
    });

    final data = (json['data'] as Map?)?.cast<String, dynamic>() ?? json;
    return (data['id'] as num).toInt();
  }

  Future<void> deleteProgram({
    required int facilityId,
    required int programId,
  }) async {
    await api.deleteProgram(facilityId, programId);
  }
}
