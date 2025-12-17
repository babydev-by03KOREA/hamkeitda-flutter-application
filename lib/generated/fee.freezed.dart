// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/admin/domain/fee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Fee _$FeeFromJson(Map<String, dynamic> json) {
  return _Fee.fromJson(json);
}

/// @nodoc
mixin _$Fee {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'feeText')
  String get feeText => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortOrder')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this Fee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeeCopyWith<Fee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeCopyWith<$Res> {
  factory $FeeCopyWith(Fee value, $Res Function(Fee) then) =
      _$FeeCopyWithImpl<$Res, Fee>;
  @useResult
  $Res call({
    int id,
    String title,
    @JsonKey(name: 'feeText') String feeText,
    @JsonKey(name: 'sortOrder') int sortOrder,
  });
}

/// @nodoc
class _$FeeCopyWithImpl<$Res, $Val extends Fee> implements $FeeCopyWith<$Res> {
  _$FeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? feeText = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            feeText: null == feeText
                ? _value.feeText
                : feeText // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeeImplCopyWith<$Res> implements $FeeCopyWith<$Res> {
  factory _$$FeeImplCopyWith(_$FeeImpl value, $Res Function(_$FeeImpl) then) =
      __$$FeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    @JsonKey(name: 'feeText') String feeText,
    @JsonKey(name: 'sortOrder') int sortOrder,
  });
}

/// @nodoc
class __$$FeeImplCopyWithImpl<$Res> extends _$FeeCopyWithImpl<$Res, _$FeeImpl>
    implements _$$FeeImplCopyWith<$Res> {
  __$$FeeImplCopyWithImpl(_$FeeImpl _value, $Res Function(_$FeeImpl) _then)
    : super(_value, _then);

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? feeText = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$FeeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        feeText: null == feeText
            ? _value.feeText
            : feeText // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeeImpl implements _Fee {
  const _$FeeImpl({
    required this.id,
    this.title = '',
    @JsonKey(name: 'feeText') this.feeText = '',
    @JsonKey(name: 'sortOrder') this.sortOrder = 0,
  });

  factory _$FeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeeImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey(name: 'feeText')
  final String feeText;
  @override
  @JsonKey(name: 'sortOrder')
  final int sortOrder;

  @override
  String toString() {
    return 'Fee(id: $id, title: $title, feeText: $feeText, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.feeText, feeText) || other.feeText == feeText) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, feeText, sortOrder);

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeeImplCopyWith<_$FeeImpl> get copyWith =>
      __$$FeeImplCopyWithImpl<_$FeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeeImplToJson(this);
  }
}

abstract class _Fee implements Fee {
  const factory _Fee({
    required final int id,
    final String title,
    @JsonKey(name: 'feeText') final String feeText,
    @JsonKey(name: 'sortOrder') final int sortOrder,
  }) = _$FeeImpl;

  factory _Fee.fromJson(Map<String, dynamic> json) = _$FeeImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'feeText')
  String get feeText;
  @override
  @JsonKey(name: 'sortOrder')
  int get sortOrder;

  /// Create a copy of Fee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeeImplCopyWith<_$FeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
