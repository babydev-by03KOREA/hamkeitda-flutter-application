// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/facility/domain/facility_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FacilityDetail _$FacilityDetailFromJson(Map<String, dynamic> json) {
  return _FacilityDetail.fromJson(json);
}

/// @nodoc
mixin _$FacilityDetail {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get openHours => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  List<RequiredDoc> get requiredDocs => throw _privateConstructorUsedError;
  List<ProgramInfo> get programs => throw _privateConstructorUsedError;
  List<FeeInfo> get fees => throw _privateConstructorUsedError;
  List<PostInfo> get posts => throw _privateConstructorUsedError;

  /// Serializes this FacilityDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FacilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FacilityDetailCopyWith<FacilityDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FacilityDetailCopyWith<$Res> {
  factory $FacilityDetailCopyWith(
    FacilityDetail value,
    $Res Function(FacilityDetail) then,
  ) = _$FacilityDetailCopyWithImpl<$Res, FacilityDetail>;
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    String? phone,
    String? openHours,
    String? address,
    String? imageUrl,
    List<String> imageUrls,
    List<RequiredDoc> requiredDocs,
    List<ProgramInfo> programs,
    List<FeeInfo> fees,
    List<PostInfo> posts,
  });
}

/// @nodoc
class _$FacilityDetailCopyWithImpl<$Res, $Val extends FacilityDetail>
    implements $FacilityDetailCopyWith<$Res> {
  _$FacilityDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FacilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? phone = freezed,
    Object? openHours = freezed,
    Object? address = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = null,
    Object? requiredDocs = null,
    Object? programs = null,
    Object? fees = null,
    Object? posts = null,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            openHours: freezed == openHours
                ? _value.openHours
                : openHours // ignore: cast_nullable_to_non_nullable
                      as String?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrls: null == imageUrls
                ? _value.imageUrls
                : imageUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            requiredDocs: null == requiredDocs
                ? _value.requiredDocs
                : requiredDocs // ignore: cast_nullable_to_non_nullable
                      as List<RequiredDoc>,
            programs: null == programs
                ? _value.programs
                : programs // ignore: cast_nullable_to_non_nullable
                      as List<ProgramInfo>,
            fees: null == fees
                ? _value.fees
                : fees // ignore: cast_nullable_to_non_nullable
                      as List<FeeInfo>,
            posts: null == posts
                ? _value.posts
                : posts // ignore: cast_nullable_to_non_nullable
                      as List<PostInfo>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FacilityDetailImplCopyWith<$Res>
    implements $FacilityDetailCopyWith<$Res> {
  factory _$$FacilityDetailImplCopyWith(
    _$FacilityDetailImpl value,
    $Res Function(_$FacilityDetailImpl) then,
  ) = __$$FacilityDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    String? description,
    String? phone,
    String? openHours,
    String? address,
    String? imageUrl,
    List<String> imageUrls,
    List<RequiredDoc> requiredDocs,
    List<ProgramInfo> programs,
    List<FeeInfo> fees,
    List<PostInfo> posts,
  });
}

/// @nodoc
class __$$FacilityDetailImplCopyWithImpl<$Res>
    extends _$FacilityDetailCopyWithImpl<$Res, _$FacilityDetailImpl>
    implements _$$FacilityDetailImplCopyWith<$Res> {
  __$$FacilityDetailImplCopyWithImpl(
    _$FacilityDetailImpl _value,
    $Res Function(_$FacilityDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FacilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? phone = freezed,
    Object? openHours = freezed,
    Object? address = freezed,
    Object? imageUrl = freezed,
    Object? imageUrls = null,
    Object? requiredDocs = null,
    Object? programs = null,
    Object? fees = null,
    Object? posts = null,
  }) {
    return _then(
      _$FacilityDetailImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        openHours: freezed == openHours
            ? _value.openHours
            : openHours // ignore: cast_nullable_to_non_nullable
                  as String?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrls: null == imageUrls
            ? _value._imageUrls
            : imageUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        requiredDocs: null == requiredDocs
            ? _value._requiredDocs
            : requiredDocs // ignore: cast_nullable_to_non_nullable
                  as List<RequiredDoc>,
        programs: null == programs
            ? _value._programs
            : programs // ignore: cast_nullable_to_non_nullable
                  as List<ProgramInfo>,
        fees: null == fees
            ? _value._fees
            : fees // ignore: cast_nullable_to_non_nullable
                  as List<FeeInfo>,
        posts: null == posts
            ? _value._posts
            : posts // ignore: cast_nullable_to_non_nullable
                  as List<PostInfo>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FacilityDetailImpl implements _FacilityDetail {
  const _$FacilityDetailImpl({
    required this.id,
    required this.name,
    this.description,
    this.phone,
    this.openHours,
    this.address,
    this.imageUrl,
    final List<String> imageUrls = const <String>[],
    final List<RequiredDoc> requiredDocs = const [],
    final List<ProgramInfo> programs = const [],
    final List<FeeInfo> fees = const [],
    final List<PostInfo> posts = const [],
  }) : _imageUrls = imageUrls,
       _requiredDocs = requiredDocs,
       _programs = programs,
       _fees = fees,
       _posts = posts;

  factory _$FacilityDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$FacilityDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? phone;
  @override
  final String? openHours;
  @override
  final String? address;
  @override
  final String? imageUrl;
  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  final List<RequiredDoc> _requiredDocs;
  @override
  @JsonKey()
  List<RequiredDoc> get requiredDocs {
    if (_requiredDocs is EqualUnmodifiableListView) return _requiredDocs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requiredDocs);
  }

  final List<ProgramInfo> _programs;
  @override
  @JsonKey()
  List<ProgramInfo> get programs {
    if (_programs is EqualUnmodifiableListView) return _programs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  final List<FeeInfo> _fees;
  @override
  @JsonKey()
  List<FeeInfo> get fees {
    if (_fees is EqualUnmodifiableListView) return _fees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fees);
  }

  final List<PostInfo> _posts;
  @override
  @JsonKey()
  List<PostInfo> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  String toString() {
    return 'FacilityDetail(id: $id, name: $name, description: $description, phone: $phone, openHours: $openHours, address: $address, imageUrl: $imageUrl, imageUrls: $imageUrls, requiredDocs: $requiredDocs, programs: $programs, fees: $fees, posts: $posts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FacilityDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.openHours, openHours) ||
                other.openHours == openHours) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._imageUrls,
              _imageUrls,
            ) &&
            const DeepCollectionEquality().equals(
              other._requiredDocs,
              _requiredDocs,
            ) &&
            const DeepCollectionEquality().equals(other._programs, _programs) &&
            const DeepCollectionEquality().equals(other._fees, _fees) &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    phone,
    openHours,
    address,
    imageUrl,
    const DeepCollectionEquality().hash(_imageUrls),
    const DeepCollectionEquality().hash(_requiredDocs),
    const DeepCollectionEquality().hash(_programs),
    const DeepCollectionEquality().hash(_fees),
    const DeepCollectionEquality().hash(_posts),
  );

  /// Create a copy of FacilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FacilityDetailImplCopyWith<_$FacilityDetailImpl> get copyWith =>
      __$$FacilityDetailImplCopyWithImpl<_$FacilityDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FacilityDetailImplToJson(this);
  }
}

abstract class _FacilityDetail implements FacilityDetail {
  const factory _FacilityDetail({
    required final int id,
    required final String name,
    final String? description,
    final String? phone,
    final String? openHours,
    final String? address,
    final String? imageUrl,
    final List<String> imageUrls,
    final List<RequiredDoc> requiredDocs,
    final List<ProgramInfo> programs,
    final List<FeeInfo> fees,
    final List<PostInfo> posts,
  }) = _$FacilityDetailImpl;

  factory _FacilityDetail.fromJson(Map<String, dynamic> json) =
      _$FacilityDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get phone;
  @override
  String? get openHours;
  @override
  String? get address;
  @override
  String? get imageUrl;
  @override
  List<String> get imageUrls;
  @override
  List<RequiredDoc> get requiredDocs;
  @override
  List<ProgramInfo> get programs;
  @override
  List<FeeInfo> get fees;
  @override
  List<PostInfo> get posts;

  /// Create a copy of FacilityDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FacilityDetailImplCopyWith<_$FacilityDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
