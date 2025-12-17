// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/facility/domain/facility_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FacilityDetailImpl _$$FacilityDetailImplFromJson(Map<String, dynamic> json) =>
    _$FacilityDetailImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      openHours: json['openHours'] as String?,
      address: json['address'] as String?,
      imageUrl: json['imageUrl'] as String?,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      requiredDocs:
          (json['requiredDocs'] as List<dynamic>?)
              ?.map((e) => RequiredDoc.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      programs:
          (json['programs'] as List<dynamic>?)
              ?.map((e) => ProgramInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      fees:
          (json['fees'] as List<dynamic>?)
              ?.map((e) => FeeInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      posts:
          (json['posts'] as List<dynamic>?)
              ?.map((e) => PostInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FacilityDetailImplToJson(
  _$FacilityDetailImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'phone': instance.phone,
  'openHours': instance.openHours,
  'address': instance.address,
  'imageUrl': instance.imageUrl,
  'imageUrls': instance.imageUrls,
  'requiredDocs': instance.requiredDocs,
  'programs': instance.programs,
  'fees': instance.fees,
  'posts': instance.posts,
};
