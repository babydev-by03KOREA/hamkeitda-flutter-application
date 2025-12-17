// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/facility/domain/facility.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Facility _$FacilityFromJson(Map<String, dynamic> json) {
  return _Facility.fromJson(json);
}

/// @nodoc
mixin _$Facility {
  int get id =>
      throw _privateConstructorUsedError; // MarkerId가 String이라 지금 코드와 맞춤
  String get name => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get openHours => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // 대표 1장 (지도 카드에서 사용)
  String? get imageUrl =>
      throw _privateConstructorUsedError; // 상세에서 여러장 (서버가 주면 받기)
  List<String> get imageUrls => throw _privateConstructorUsedError;

  /// Serializes this Facility to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Facility
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FacilityCopyWith<Facility> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacilityCopyWith<$Res> {
  factory $FacilityCopyWith(Facility value, $Res Function(Facility) then) =
      _$FacilityCopyWithImpl<$Res, Facility>;
  @useResult
  $Res call({
    int id,
    String name,
    double lat,
    double lng,
    String? phone,
    String? openHours,
    String? description,
    String? imageUrl,
    List<String> imageUrls,
  });
}

/// @nodoc
class _$FacilityCopyWithImpl<$Res, $Val extends Facility>
    implements $FacilityCopyWith<$Res> {
  _$FacilityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Facility
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lat = null,
    Object? lng = null,
    Object? phone = freezed,
    Object? openHours = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            openHours: freezed == openHours
                ? _value.openHours
                : openHours // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FacilityImplCopyWith<$Res>
    implements $FacilityCopyWith<$Res> {
  factory _$$FacilityImplCopyWith(
    _$FacilityImpl value,
    $Res Function(_$FacilityImpl) then,
  ) = __$$FacilityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    double lat,
    double lng,
    String? phone,
    String? openHours,
    String? description,
    String? imageUrl,
    List<String> imageUrls,
  });
}

/// @nodoc
class __$$FacilityImplCopyWithImpl<$Res>
    extends _$FacilityCopyWithImpl<$Res, _$FacilityImpl>
    implements _$$FacilityImplCopyWith<$Res> {
  __$$FacilityImplCopyWithImpl(
    _$FacilityImpl _value,
    $Res Function(_$FacilityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Facility
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lat = null,
    Object? lng = null,
    Object? phone = freezed,
    Object? openHours = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = null,
  }) {
    return _then(
      _$FacilityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        openHours: freezed == openHours
            ? _value.openHours
            : openHours // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FacilityImpl extends _Facility {
  const _$FacilityImpl({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.phone,
    this.openHours,
    this.description,
    this.imageUrl,
    final List<String> imageUrls = const <String>[],
  }) : _imageUrls = imageUrls,
       super._();

  factory _$FacilityImpl.fromJson(Map<String, dynamic> json) =>
      _$$FacilityImplFromJson(json);

  @override
  final int id;
  // MarkerId가 String이라 지금 코드와 맞춤
  @override
  final String name;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String? phone;
  @override
  final String? openHours;
  @override
  final String? description;
  // 대표 1장 (지도 카드에서 사용)
  @override
  final String? imageUrl;
  // 상세에서 여러장 (서버가 주면 받기)
  final List<String> _imageUrls;
  // 상세에서 여러장 (서버가 주면 받기)
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString() {
    return 'Facility(id: $id, name: $name, lat: $lat, lng: $lng, phone: $phone, openHours: $openHours, description: $description, imageUrl: $imageUrl, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FacilityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.openHours, openHours) ||
                other.openHours == openHours) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    lat,
    lng,
    phone,
    openHours,
    description,
    imageUrl,
    const DeepCollectionEquality().hash(_imageUrls),
  );

  /// Create a copy of Facility
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FacilityImplCopyWith<_$FacilityImpl> get copyWith =>
      __$$FacilityImplCopyWithImpl<_$FacilityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FacilityImplToJson(this);
  }
}

abstract class _Facility extends Facility {
  const factory _Facility({
    required final int id,
    required final String name,
    required final double lat,
    required final double lng,
    final String? phone,
    final String? openHours,
    final String? description,
    final String? imageUrl,
    final List<String> imageUrls,
  }) = _$FacilityImpl;
  const _Facility._() : super._();

  factory _Facility.fromJson(Map<String, dynamic> json) =
      _$FacilityImpl.fromJson;

  @override
  int get id; // MarkerId가 String이라 지금 코드와 맞춤
  @override
  String get name;
  @override
  double get lat;
  @override
  double get lng;
  @override
  String? get phone;
  @override
  String? get openHours;
  @override
  String? get description; // 대표 1장 (지도 카드에서 사용)
  @override
  String? get imageUrl; // 상세에서 여러장 (서버가 주면 받기)
  @override
  List<String> get imageUrls;

  /// Create a copy of Facility
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FacilityImplCopyWith<_$FacilityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
