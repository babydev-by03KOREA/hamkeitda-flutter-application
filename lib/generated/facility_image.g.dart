// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/admin/domain/facility_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FacilityImageImpl _$$FacilityImageImplFromJson(Map<String, dynamic> json) =>
    _$FacilityImageImpl(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      isPrimary: json['isPrimary'] as bool,
      caption: json['caption'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FacilityImageImplToJson(_$FacilityImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'isPrimary': instance.isPrimary,
      'caption': instance.caption,
      'sortOrder': instance.sortOrder,
    };
