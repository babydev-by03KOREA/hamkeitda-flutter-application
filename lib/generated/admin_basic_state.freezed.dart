// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/admin/domain/admin_basic_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminBasicState _$AdminBasicStateFromJson(Map<String, dynamic> json) {
  return _AdminBasicState.fromJson(json);
}

/// @nodoc
mixin _$AdminBasicState {
  String get name => throw _privateConstructorUsedError;
  String get openHours => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this AdminBasicState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminBasicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminBasicStateCopyWith<AdminBasicState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminBasicStateCopyWith<$Res> {
  factory $AdminBasicStateCopyWith(
    AdminBasicState value,
    $Res Function(AdminBasicState) then,
  ) = _$AdminBasicStateCopyWithImpl<$Res, AdminBasicState>;
  @useResult
  $Res call({
    String name,
    String openHours,
    String phone,
    String address,
    String description,
    String? imageUrl,
  });
}

/// @nodoc
class _$AdminBasicStateCopyWithImpl<$Res, $Val extends AdminBasicState>
    implements $AdminBasicStateCopyWith<$Res> {
  _$AdminBasicStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminBasicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? openHours = null,
    Object? phone = null,
    Object? address = null,
    Object? description = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            openHours: null == openHours
                ? _value.openHours
                : openHours // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminBasicStateImplCopyWith<$Res>
    implements $AdminBasicStateCopyWith<$Res> {
  factory _$$AdminBasicStateImplCopyWith(
    _$AdminBasicStateImpl value,
    $Res Function(_$AdminBasicStateImpl) then,
  ) = __$$AdminBasicStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String openHours,
    String phone,
    String address,
    String description,
    String? imageUrl,
  });
}

/// @nodoc
class __$$AdminBasicStateImplCopyWithImpl<$Res>
    extends _$AdminBasicStateCopyWithImpl<$Res, _$AdminBasicStateImpl>
    implements _$$AdminBasicStateImplCopyWith<$Res> {
  __$$AdminBasicStateImplCopyWithImpl(
    _$AdminBasicStateImpl _value,
    $Res Function(_$AdminBasicStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminBasicState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? openHours = null,
    Object? phone = null,
    Object? address = null,
    Object? description = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$AdminBasicStateImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        openHours: null == openHours
            ? _value.openHours
            : openHours // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminBasicStateImpl implements _AdminBasicState {
  const _$AdminBasicStateImpl({
    required this.name,
    required this.openHours,
    required this.phone,
    required this.address,
    required this.description,
    this.imageUrl,
  });

  factory _$AdminBasicStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminBasicStateImplFromJson(json);

  @override
  final String name;
  @override
  final String openHours;
  @override
  final String phone;
  @override
  final String address;
  @override
  final String description;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'AdminBasicState(name: $name, openHours: $openHours, phone: $phone, address: $address, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminBasicStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.openHours, openHours) ||
                other.openHours == openHours) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    openHours,
    phone,
    address,
    description,
    imageUrl,
  );

  /// Create a copy of AdminBasicState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminBasicStateImplCopyWith<_$AdminBasicStateImpl> get copyWith =>
      __$$AdminBasicStateImplCopyWithImpl<_$AdminBasicStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminBasicStateImplToJson(this);
  }
}

abstract class _AdminBasicState implements AdminBasicState {
  const factory _AdminBasicState({
    required final String name,
    required final String openHours,
    required final String phone,
    required final String address,
    required final String description,
    final String? imageUrl,
  }) = _$AdminBasicStateImpl;

  factory _AdminBasicState.fromJson(Map<String, dynamic> json) =
      _$AdminBasicStateImpl.fromJson;

  @override
  String get name;
  @override
  String get openHours;
  @override
  String get phone;
  @override
  String get address;
  @override
  String get description;
  @override
  String? get imageUrl;

  /// Create a copy of AdminBasicState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminBasicStateImplCopyWith<_$AdminBasicStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
