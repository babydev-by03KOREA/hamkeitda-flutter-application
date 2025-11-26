// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/facility/domain/post_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostInfoImpl _$$PostInfoImplFromJson(Map<String, dynamic> json) =>
    _$PostInfoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      preview: json['preview'] as String?,
    );

Map<String, dynamic> _$$PostInfoImplToJson(_$PostInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'preview': instance.preview,
    };
