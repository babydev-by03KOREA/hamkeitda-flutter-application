// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/admin/domain/admin_basic_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminBasicStateImpl _$$AdminBasicStateImplFromJson(
  Map<String, dynamic> json,
) => _$AdminBasicStateImpl(
  name: json['name'] as String,
  openHours: json['openHours'] as String,
  phone: json['phone'] as String,
  address: json['address'] as String,
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$AdminBasicStateImplToJson(
  _$AdminBasicStateImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'openHours': instance.openHours,
  'phone': instance.phone,
  'address': instance.address,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
};
