// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/admin/domain/facility_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FacilityImage _$FacilityImageFromJson(Map<String, dynamic> json) {
  return _FacilityImage.fromJson(json);
}

/// @nodoc
mixin _$FacilityImage {
  int get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this FacilityImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FacilityImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FacilityImageCopyWith<FacilityImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacilityImageCopyWith<$Res> {
  factory $FacilityImageCopyWith(
    FacilityImage value,
    $Res Function(FacilityImage) then,
  ) = _$FacilityImageCopyWithImpl<$Res, FacilityImage>;
  @useResult
  $Res call({
    int id,
    String url,
    bool isPrimary,
    String? caption,
    int sortOrder,
  });
}

/// @nodoc
class _$FacilityImageCopyWithImpl<$Res, $Val extends FacilityImage>
    implements $FacilityImageCopyWith<$Res> {
  _$FacilityImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FacilityImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? isPrimary = null,
    Object? caption = freezed,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            isPrimary: null == isPrimary
                ? _value.isPrimary
                : isPrimary // ignore: cast_nullable_to_non_nullable
                      as bool,
            caption: freezed == caption
                ? _value.caption
                : caption // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$FacilityImageImplCopyWith<$Res>
    implements $FacilityImageCopyWith<$Res> {
  factory _$$FacilityImageImplCopyWith(
    _$FacilityImageImpl value,
    $Res Function(_$FacilityImageImpl) then,
  ) = __$$FacilityImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String url,
    bool isPrimary,
    String? caption,
    int sortOrder,
  });
}

/// @nodoc
class __$$FacilityImageImplCopyWithImpl<$Res>
    extends _$FacilityImageCopyWithImpl<$Res, _$FacilityImageImpl>
    implements _$$FacilityImageImplCopyWith<$Res> {
  __$$FacilityImageImplCopyWithImpl(
    _$FacilityImageImpl _value,
    $Res Function(_$FacilityImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FacilityImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? isPrimary = null,
    Object? caption = freezed,
    Object? sortOrder = null,
  }) {
    return _then(
      _$FacilityImageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        isPrimary: null == isPrimary
            ? _value.isPrimary
            : isPrimary // ignore: cast_nullable_to_non_nullable
                  as bool,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$FacilityImageImpl implements _FacilityImage {
  const _$FacilityImageImpl({
    required this.id,
    required this.url,
    required this.isPrimary,
    this.caption,
    this.sortOrder = 0,
  });

  factory _$FacilityImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$FacilityImageImplFromJson(json);

  @override
  final int id;
  @override
  final String url;
  @override
  final bool isPrimary;
  @override
  final String? caption;
  @override
  @JsonKey()
  final int sortOrder;

  @override
  String toString() {
    return 'FacilityImage(id: $id, url: $url, isPrimary: $isPrimary, caption: $caption, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FacilityImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, url, isPrimary, caption, sortOrder);

  /// Create a copy of FacilityImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FacilityImageImplCopyWith<_$FacilityImageImpl> get copyWith =>
      __$$FacilityImageImplCopyWithImpl<_$FacilityImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FacilityImageImplToJson(this);
  }
}

abstract class _FacilityImage implements FacilityImage {
  const factory _FacilityImage({
    required final int id,
    required final String url,
    required final bool isPrimary,
    final String? caption,
    final int sortOrder,
  }) = _$FacilityImageImpl;

  factory _FacilityImage.fromJson(Map<String, dynamic> json) =
      _$FacilityImageImpl.fromJson;

  @override
  int get id;
  @override
  String get url;
  @override
  bool get isPrimary;
  @override
  String? get caption;
  @override
  int get sortOrder;

  /// Create a copy of FacilityImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FacilityImageImplCopyWith<_$FacilityImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
