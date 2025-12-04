class CounselRequest {
  final String answers;
  final String applicantName;
  final String? applicantPhone;

  CounselRequest({
    required this.answers,
    required this.applicantName,
    this.applicantPhone,
  });

  Map<String, dynamic> toJson() => {
    "answers": answers,
    "applicantName": applicantName,
    "applicantPhone": applicantPhone,
  };
}