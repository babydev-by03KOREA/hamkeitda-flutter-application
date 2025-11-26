import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/user.freezed.dart';
part '../../../generated/user.g.dart';

enum UserRole { guest, member, facilityAdmin, superAdmin }

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    String? name,
    @Default(UserRole.member) UserRole role,
    String? facilityId,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
