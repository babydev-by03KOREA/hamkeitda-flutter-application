// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/auth/domain/token_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TokenPair _$TokenPairFromJson(Map<String, dynamic> json) {
  return _TokenPair.fromJson(json);
}

/// @nodoc
mixin _$TokenPair {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  int get expiresIn => throw _privateConstructorUsedError;
  int get refreshExpiresIn => throw _privateConstructorUsedError;
  String get role =>
      throw _privateConstructorUsedError; // "ROLE_USER" 같은 raw string
  int get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get facilityId => throw _privateConstructorUsedError;

  /// Serializes this TokenPair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenPairCopyWith<TokenPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPairCopyWith<$Res> {
  factory $TokenPairCopyWith(TokenPair value, $Res Function(TokenPair) then) =
      _$TokenPairCopyWithImpl<$Res, TokenPair>;
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    int expiresIn,
    int refreshExpiresIn,
    String role,
    int userId,
    String name,
    int? facilityId,
  });
}

/// @nodoc
class _$TokenPairCopyWithImpl<$Res, $Val extends TokenPair>
    implements $TokenPairCopyWith<$Res> {
  _$TokenPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? refreshExpiresIn = null,
    Object? role = null,
    Object? userId = null,
    Object? name = null,
    Object? facilityId = freezed,
  }) {
    return _then(
      _value.copyWith(
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            expiresIn: null == expiresIn
                ? _value.expiresIn
                : expiresIn // ignore: cast_nullable_to_non_nullable
                      as int,
            refreshExpiresIn: null == refreshExpiresIn
                ? _value.refreshExpiresIn
                : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
                      as int,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            facilityId: freezed == facilityId
                ? _value.facilityId
                : facilityId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TokenPairImplCopyWith<$Res>
    implements $TokenPairCopyWith<$Res> {
  factory _$$TokenPairImplCopyWith(
    _$TokenPairImpl value,
    $Res Function(_$TokenPairImpl) then,
  ) = __$$TokenPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String accessToken,
    String refreshToken,
    int expiresIn,
    int refreshExpiresIn,
    String role,
    int userId,
    String name,
    int? facilityId,
  });
}

/// @nodoc
class __$$TokenPairImplCopyWithImpl<$Res>
    extends _$TokenPairCopyWithImpl<$Res, _$TokenPairImpl>
    implements _$$TokenPairImplCopyWith<$Res> {
  __$$TokenPairImplCopyWithImpl(
    _$TokenPairImpl _value,
    $Res Function(_$TokenPairImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresIn = null,
    Object? refreshExpiresIn = null,
    Object? role = null,
    Object? userId = null,
    Object? name = null,
    Object? facilityId = freezed,
  }) {
    return _then(
      _$TokenPairImpl(
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        expiresIn: null == expiresIn
            ? _value.expiresIn
            : expiresIn // ignore: cast_nullable_to_non_nullable
                  as int,
        refreshExpiresIn: null == refreshExpiresIn
            ? _value.refreshExpiresIn
            : refreshExpiresIn // ignore: cast_nullable_to_non_nullable
                  as int,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        facilityId: freezed == facilityId
            ? _value.facilityId
            : facilityId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenPairImpl implements _TokenPair {
  const _$TokenPairImpl({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.role,
    required this.userId,
    required this.name,
    this.facilityId,
  });

  factory _$TokenPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenPairImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final int expiresIn;
  @override
  final int refreshExpiresIn;
  @override
  final String role;
  // "ROLE_USER" 같은 raw string
  @override
  final int userId;
  @override
  final String name;
  @override
  final int? facilityId;

  @override
  String toString() {
    return 'TokenPair(accessToken: $accessToken, refreshToken: $refreshToken, expiresIn: $expiresIn, refreshExpiresIn: $refreshExpiresIn, role: $role, userId: $userId, name: $name, facilityId: $facilityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPairImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            (identical(other.refreshExpiresIn, refreshExpiresIn) ||
                other.refreshExpiresIn == refreshExpiresIn) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.facilityId, facilityId) ||
                other.facilityId == facilityId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    accessToken,
    refreshToken,
    expiresIn,
    refreshExpiresIn,
    role,
    userId,
    name,
    facilityId,
  );

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPairImplCopyWith<_$TokenPairImpl> get copyWith =>
      __$$TokenPairImplCopyWithImpl<_$TokenPairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenPairImplToJson(this);
  }
}

abstract class _TokenPair implements TokenPair {
  const factory _TokenPair({
    required final String accessToken,
    required final String refreshToken,
    required final int expiresIn,
    required final int refreshExpiresIn,
    required final String role,
    required final int userId,
    required final String name,
    final int? facilityId,
  }) = _$TokenPairImpl;

  factory _TokenPair.fromJson(Map<String, dynamic> json) =
      _$TokenPairImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  int get expiresIn;
  @override
  int get refreshExpiresIn;
  @override
  String get role; // "ROLE_USER" 같은 raw string
  @override
  int get userId;
  @override
  String get name;
  @override
  int? get facilityId;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenPairImplCopyWith<_$TokenPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
