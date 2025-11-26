// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../features/auth/domain/user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(
  Map<String, dynamic> json,
) => _$AppUserImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.member,
  facilityId: json['facilityId'] as String?,
);

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'role': _$UserRoleEnumMap[instance.role]!,
      'facilityId': instance.facilityId,
    };

const _$UserRoleEnumMap = {
  UserRole.guest: 'guest',
  UserRole.member: 'member',
  UserRole.facilityAdmin: 'facilityAdmin',
  UserRole.superAdmin: 'superAdmin',
};
