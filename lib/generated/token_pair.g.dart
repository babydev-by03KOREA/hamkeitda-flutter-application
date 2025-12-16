// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/auth/domain/token_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenPairImpl _$$TokenPairImplFromJson(Map<String, dynamic> json) =>
    _$TokenPairImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      expiresIn: (json['expiresIn'] as num).toInt(),
      refreshExpiresIn: (json['refreshExpiresIn'] as num).toInt(),
      role: json['role'] as String,
      userId: (json['userId'] as num).toInt(),
      name: json['name'] as String,
      facilityId: (json['facilityId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TokenPairImplToJson(_$TokenPairImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'refreshExpiresIn': instance.refreshExpiresIn,
      'role': instance.role,
      'userId': instance.userId,
      'name': instance.name,
      'facilityId': instance.facilityId,
    };
