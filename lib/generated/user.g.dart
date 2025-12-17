// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/auth/domain/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
      role: const UserRoleConverter().fromJson(json['role'] as String),
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      facilityId: (json['facilityId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'role': const UserRoleConverter().toJson(instance.role),
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'facilityId': instance.facilityId,
    };
