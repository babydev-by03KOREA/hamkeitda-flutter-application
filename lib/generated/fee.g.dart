// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/admin/domain/fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeeImpl _$$FeeImplFromJson(Map<String, dynamic> json) => _$FeeImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  feeText: json['feeText'] as String? ?? '',
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$FeeImplToJson(_$FeeImpl instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'feeText': instance.feeText,
  'sortOrder': instance.sortOrder,
};
