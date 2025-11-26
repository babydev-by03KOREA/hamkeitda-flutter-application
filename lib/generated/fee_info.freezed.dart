// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/facility/domain/fee_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FeeInfo _$FeeInfoFromJson(Map<String, dynamic> json) {
  return _FeeInfo.fromJson(json);
}

/// @nodoc
mixin _$FeeInfo {
  String get item => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this FeeInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeeInfoCopyWith<FeeInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeInfoCopyWith<$Res> {
  factory $FeeInfoCopyWith(FeeInfo value, $Res Function(FeeInfo) then) =
      _$FeeInfoCopyWithImpl<$Res, FeeInfo>;
  @useResult
  $Res call({String item, String price, String? note});
}

/// @nodoc
class _$FeeInfoCopyWithImpl<$Res, $Val extends FeeInfo>
    implements $FeeInfoCopyWith<$Res> {
  _$FeeInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? price = null,
    Object? note = freezed,
  }) {
    return _then(
      _value.copyWith(
            item: null == item
                ? _value.item
                : item // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeeInfoImplCopyWith<$Res> implements $FeeInfoCopyWith<$Res> {
  factory _$$FeeInfoImplCopyWith(
    _$FeeInfoImpl value,
    $Res Function(_$FeeInfoImpl) then,
  ) = __$$FeeInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String item, String price, String? note});
}

/// @nodoc
class __$$FeeInfoImplCopyWithImpl<$Res>
    extends _$FeeInfoCopyWithImpl<$Res, _$FeeInfoImpl>
    implements _$$FeeInfoImplCopyWith<$Res> {
  __$$FeeInfoImplCopyWithImpl(
    _$FeeInfoImpl _value,
    $Res Function(_$FeeInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? price = null,
    Object? note = freezed,
  }) {
    return _then(
      _$FeeInfoImpl(
        item: null == item
            ? _value.item
            : item // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeeInfoImpl implements _FeeInfo {
  const _$FeeInfoImpl({required this.item, required this.price, this.note});

  factory _$FeeInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeeInfoImplFromJson(json);

  @override
  final String item;
  @override
  final String price;
  @override
  final String? note;

  @override
  String toString() {
    return 'FeeInfo(item: $item, price: $price, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeeInfoImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, item, price, note);

  /// Create a copy of FeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeeInfoImplCopyWith<_$FeeInfoImpl> get copyWith =>
      __$$FeeInfoImplCopyWithImpl<_$FeeInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeeInfoImplToJson(this);
  }
}

abstract class _FeeInfo implements FeeInfo {
  const factory _FeeInfo({
    required final String item,
    required final String price,
    final String? note,
  }) = _$FeeInfoImpl;

  factory _FeeInfo.fromJson(Map<String, dynamic> json) = _$FeeInfoImpl.fromJson;

  @override
  String get item;
  @override
  String get price;
  @override
  String? get note;

  /// Create a copy of FeeInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeeInfoImplCopyWith<_$FeeInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
