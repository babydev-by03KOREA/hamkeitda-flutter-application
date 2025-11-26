// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/facility/domain/facility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FacilityImpl _$$FacilityImplFromJson(Map<String, dynamic> json) =>
    _$FacilityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      openHours: json['openHours'] as String?,
      imageUrl: json['imageUrl'] as String?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$FacilityImplToJson(_$FacilityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'openHours': instance.openHours,
      'imageUrl': instance.imageUrl,
      'lat': instance.lat,
      'lng': instance.lng,
      'description': instance.description,
    };
