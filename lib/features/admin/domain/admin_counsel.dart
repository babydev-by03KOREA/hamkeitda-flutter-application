class AdminCounselSummary {
  final int id;
  final String applicantName;
  final String? applicantPhone;
  final DateTime createdAt;

  AdminCounselSummary({
    required this.id,
    required this.applicantName,
    required this.createdAt,
    this.applicantPhone,
  });

  factory AdminCounselSummary.fromJson(Map<String, dynamic> json) {
    return AdminCounselSummary(
      id: json['id'] as int,
      applicantName: json['applicantName'] as String,
      applicantPhone: json['applicantPhone'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

/// 서버에서 answers 를 그대로 내려주는 형태라면 이렇게
class AdminCounselDetail {
  final AdminCounselSummary summary;
  final Map<String, dynamic> answersJson;

  AdminCounselDetail({required this.summary, required this.answersJson});

  factory AdminCounselDetail.fromJson(Map<String, dynamic> json) {
    return AdminCounselDetail(
      summary: AdminCounselSummary.fromJson(json),
      answersJson: json['answers'] as Map<String, dynamic>,
    );
  }
}
