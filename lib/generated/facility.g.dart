// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/facility/domain/facility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FacilityImpl _$$FacilityImplFromJson(Map<String, dynamic> json) =>
    _$FacilityImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      phone: json['phone'] as String?,
      openHours: json['openHours'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$FacilityImplToJson(_$FacilityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'phone': instance.phone,
      'openHours': instance.openHours,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'imageUrls': instance.imageUrls,
    };
