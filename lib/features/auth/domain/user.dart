import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/user.freezed.dart';

part '../../../generated/user.g.dart';

enum UserRole { guest, user, facility }

class UserRoleConverter implements JsonConverter<UserRole, String> {
  const UserRoleConverter();

  @override
  UserRole fromJson(String json) {
    // 1) ROLE_ 있으면 제거
    final normalized = json.startsWith('ROLE_') ? json.substring(5) : json;

    // 2) 대소문자/형태 normalize (ROLE_FACILITY / facility / FACILITY 모두 대응)
    final key = normalized.toLowerCase();

    // 3) enum 매핑
    switch (key) {
      case 'guest':
        return UserRole.guest;
      case 'user':
        return UserRole.user;
      case 'facility':
        return UserRole.facility;
      default:
        return UserRole.guest;
    }
  }

  @override
  String toJson(UserRole object) {
    return object.name;
  }
}

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required int id,
    @Default('') String email,
    @Default('') String name,
    @UserRoleConverter() required UserRole role,

    @Default('') String accessToken,
    @Default('') String refreshToken,

    int? facilityId,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
