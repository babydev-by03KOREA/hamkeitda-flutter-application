import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_detail.dart';

/// 시설별 상담 목록
final counselListProvider = FutureProvider.family<List<CounselDetail>, String>((
  ref,
  facilityId,
) async {
  final dio = ref.read(dioProvider);

  final res = await dio.get('/admin/facility/$facilityId/counsels');

  final list = (res.data as List).map((e) {
    final map = (e as Map).cast<String, dynamic>();

    // 서버에서 answers가 String JSON이면 여기서 decode
    final rawAnswers = map['answers'] ?? map['answersJson'];

    final answersMap = switch (rawAnswers) {
      Map<String, dynamic> m => m,
      String s => jsonDecode(s) as Map<String, dynamic>,
      _ => <String, dynamic>{},
    };

    return CounselDetail(
      id: map['id'],
      facilityId: map['facilityId'],
      applicantName: map['applicantName'] ?? '',
      applicantPhone: map['applicantPhone'],
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      answersJson: answersMap,
    );
  }).toList();

  return list;
});
