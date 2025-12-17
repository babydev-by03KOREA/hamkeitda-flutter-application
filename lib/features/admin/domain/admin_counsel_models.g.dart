// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_counsel_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounselNotification _$CounselNotificationFromJson(Map<String, dynamic> json) =>
    CounselNotification(
      id: (json['id'] as num).toInt(),
      facilityId: (json['facilityId'] as num).toInt(),
      facilityName: json['facilityName'] as String,
      applicantName: json['applicantName'] as String,
      applicantPhone: json['applicantPhone'] as String?,
      answers: json['answers'] as String,
    );

Map<String, dynamic> _$CounselNotificationToJson(
  CounselNotification instance,
) => <String, dynamic>{
  'id': instance.id,
  'facilityId': instance.facilityId,
  'facilityName': instance.facilityName,
  'applicantName': instance.applicantName,
  'applicantPhone': instance.applicantPhone,
  'answers': instance.answers,
};

CounselPageResponse _$CounselPageResponseFromJson(Map<String, dynamic> json) =>
    CounselPageResponse(
      content: (json['content'] as List<dynamic>)
          .map((e) => CounselNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num).toInt(),
      last: json['last'] as bool,
      totalElements: (json['totalElements'] as num).toInt(),
    );

Map<String, dynamic> _$CounselPageResponseToJson(
  CounselPageResponse instance,
) => <String, dynamic>{
  'content': instance.content,
  'number': instance.number,
  'last': instance.last,
  'totalElements': instance.totalElements,
};
