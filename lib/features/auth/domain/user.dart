import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/user.freezed.dart';
part '../../../generated/user.g.dart';

enum UserRole { guest, member, facilityAdmin, superAdmin }

UserRole _roleFromJson(String v) {
  switch (v) {
    case 'ROLE_FACILITY':
      return UserRole.facilityAdmin;
    case 'ROLE_ADMIN':
    case 'ROLE_SUPER_ADMIN':
      return UserRole.superAdmin;
    case 'ROLE_USER':
      return UserRole.member;
    case 'ROLE_GUEST':
    default:
      return UserRole.guest;
  }
}

String _roleToJson(UserRole r) {
  switch (r) {
    case UserRole.facilityAdmin:
      return 'ROLE_FACILITY';
    case UserRole.superAdmin:
      return 'ROLE_SUPER_ADMIN';
    case UserRole.member:
      return 'ROLE_USER';
    case UserRole.guest:
      return 'ROLE_GUEST';
  }
}

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required int id,

    // 서버 로그인 응답에 email이 없으면 기본값으로 처리
    @Default('') String email,

    @Default('') String name,

    required UserRole role,

    required String accessToken,
    required String refreshToken,

    int? facilityId,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}