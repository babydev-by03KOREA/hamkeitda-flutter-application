import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/token_pair.freezed.dart';
part '../../../generated/token_pair.g.dart';

@freezed
class TokenPair with _$TokenPair {
  const factory TokenPair({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required int refreshExpiresIn,
    required String role,     // "ROLE_USER" 같은 raw string
    required int userId,
    required String name,
    int? facilityId,
  }) = _TokenPair;

  factory TokenPair.fromJson(Map<String, dynamic> json) => _$TokenPairFromJson(json);
}