// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/admin/domain/necessary_document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NecessaryDocumentImpl _$$NecessaryDocumentImplFromJson(
  Map<String, dynamic> json,
) => _$NecessaryDocumentImpl(
  id: (json['id'] as num).toInt(),
  title: json['name'] as String? ?? '',
  howTo: json['howToGet'] as String?,
  sortOrder: (json['sortOrder'] as num?)?.toInt(),
);

Map<String, dynamic> _$$NecessaryDocumentImplToJson(
  _$NecessaryDocumentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.title,
  'howToGet': instance.howTo,
  'sortOrder': instance.sortOrder,
};
