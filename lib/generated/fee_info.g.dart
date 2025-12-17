// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/facility/domain/fee_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeeInfoImpl _$$FeeInfoImplFromJson(Map<String, dynamic> json) =>
    _$FeeInfoImpl(
      item: json['item'] as String? ?? '',
      price: json['price'] as String? ?? '',
      note: json['note'] as String?,
    );

Map<String, dynamic> _$$FeeInfoImplToJson(_$FeeInfoImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'price': instance.price,
      'note': instance.note,
    };
