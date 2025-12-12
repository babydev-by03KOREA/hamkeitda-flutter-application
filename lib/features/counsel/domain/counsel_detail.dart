import 'dart:convert';

class CounselDetail {
  final int id;
  final int facilityId;
  final String applicantName;
  final String applicantPhone;
  final DateTime? createdAt;

  /// 서버에 저장된 상담 신청서 (JSON String → Map)
  final Map<String, dynamic> answersJson;

  CounselDetail({
    required this.id,
    required this.facilityId,
    required this.applicantName,
    required this.applicantPhone,
    required this.createdAt,
    required this.answersJson,
  });

  factory CounselDetail.fromJson(Map<String, dynamic> json) {
    return CounselDetail(
      id: json['id'],
      facilityId: json['facilityId'],
      applicantName: json['applicantName'],
      applicantPhone: json['applicantPhone'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      answersJson: json['answersJson'] is String
          ? jsonDecode(json['answersJson'])
          : (json['answersJson'] as Map).cast<String, dynamic>(),
    );
  }
}