import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'admin_counsel_models.g.dart';

@JsonSerializable()
class CounselNotification {
  final int id;
  final int facilityId;
  final String facilityName;
  final String applicantName;
  final String? applicantPhone;
  final String answers;

  CounselNotification({
    required this.id,
    required this.facilityId,
    required this.facilityName,
    required this.applicantName,
    required this.applicantPhone,
    required this.answers,
  });

  @JsonKey(ignore: true)
  Map<String, dynamic> get answersJson {
    try {
      final decoded = jsonDecode(answers);
      return decoded is Map<String, dynamic> ? decoded : <String, dynamic>{};
    } catch (_) {
      return <String, dynamic>{};
    }
  }

  factory CounselNotification.fromJson(Map<String, dynamic> json) =>
      _$CounselNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$CounselNotificationToJson(this);
}

@JsonSerializable()
class CounselPageResponse {
  final List<CounselNotification> content;
  final int number;
  final bool last;
  final int totalElements;

  CounselPageResponse({
    required this.content,
    required this.number,
    required this.last,
    required this.totalElements,
  });

  factory CounselPageResponse.fromJson(Map<String, dynamic> json) =>
      _$CounselPageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CounselPageResponseToJson(this);
}