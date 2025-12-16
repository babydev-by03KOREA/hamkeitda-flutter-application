import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/user.freezed.dart';
part '../../../generated/user.g.dart';

enum UserRole { guest, user, facility }

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required int id,
    @Default('') String email,
    @Default('') String name,
    required UserRole role,
    required String accessToken,
    required String refreshToken,
    int? facilityId,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}