// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/admin/domain/bbs_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BbsPostImpl _$$BbsPostImplFromJson(Map<String, dynamic> json) =>
    _$BbsPostImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String,
      isPinned: json['isPinned'] as bool,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$BbsPostImplToJson(_$BbsPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'isPinned': instance.isPinned,
      'createdAt': instance.createdAt,
    };

_$PageResultImpl<T> _$$PageResultImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$PageResultImpl<T>(
  content:
      (json['content'] as List<dynamic>?)?.map(fromJsonT).toList() ?? const [],
  totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  number: (json['number'] as num?)?.toInt() ?? 0,
  size: (json['size'] as num?)?.toInt() ?? 20,
  first: json['first'] as bool? ?? false,
  last: json['last'] as bool? ?? false,
);

Map<String, dynamic> _$$PageResultImplToJson<T>(
  _$PageResultImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'content': instance.content.map(toJsonT).toList(),
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
  'number': instance.number,
  'size': instance.size,
  'first': instance.first,
  'last': instance.last,
};
