// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/admin/domain/bbs_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BbsPost _$BbsPostFromJson(Map<String, dynamic> json) {
  return _BbsPost.fromJson(json);
}

/// @nodoc
mixin _$BbsPost {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BbsPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BbsPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BbsPostCopyWith<BbsPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BbsPostCopyWith<$Res> {
  factory $BbsPostCopyWith(BbsPost value, $Res Function(BbsPost) then) =
      _$BbsPostCopyWithImpl<$Res, BbsPost>;
  @useResult
  $Res call({
    int id,
    String title,
    String content,
    bool isPinned,
    String createdAt,
  });
}

/// @nodoc
class _$BbsPostCopyWithImpl<$Res, $Val extends BbsPost>
    implements $BbsPostCopyWith<$Res> {
  _$BbsPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BbsPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? isPinned = null,
    Object? createdAt = null,
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
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BbsPostImplCopyWith<$Res> implements $BbsPostCopyWith<$Res> {
  factory _$$BbsPostImplCopyWith(
    _$BbsPostImpl value,
    $Res Function(_$BbsPostImpl) then,
  ) = __$$BbsPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String content,
    bool isPinned,
    String createdAt,
  });
}

/// @nodoc
class __$$BbsPostImplCopyWithImpl<$Res>
    extends _$BbsPostCopyWithImpl<$Res, _$BbsPostImpl>
    implements _$$BbsPostImplCopyWith<$Res> {
  __$$BbsPostImplCopyWithImpl(
    _$BbsPostImpl _value,
    $Res Function(_$BbsPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BbsPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? isPinned = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$BbsPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BbsPostImpl implements _BbsPost {
  const _$BbsPostImpl({
    required this.id,
    required this.title,
    required this.content,
    required this.isPinned,
    required this.createdAt,
  });

  factory _$BbsPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$BbsPostImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final bool isPinned;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'BbsPost(id: $id, title: $title, content: $content, isPinned: $isPinned, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BbsPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, content, isPinned, createdAt);

  /// Create a copy of BbsPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BbsPostImplCopyWith<_$BbsPostImpl> get copyWith =>
      __$$BbsPostImplCopyWithImpl<_$BbsPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BbsPostImplToJson(this);
  }
}

abstract class _BbsPost implements BbsPost {
  const factory _BbsPost({
    required final int id,
    required final String title,
    required final String content,
    required final bool isPinned,
    required final String createdAt,
  }) = _$BbsPostImpl;

  factory _BbsPost.fromJson(Map<String, dynamic> json) = _$BbsPostImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  bool get isPinned;
  @override
  String get createdAt;

  /// Create a copy of BbsPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BbsPostImplCopyWith<_$BbsPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PageResult<T> _$PageResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _PageResult<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PageResult<T> {
  List<T> get content => throw _privateConstructorUsedError;
  int get totalElements => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  bool get first => throw _privateConstructorUsedError;
  bool get last => throw _privateConstructorUsedError;

  /// Serializes this PageResult to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of PageResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PageResultCopyWith<T, PageResult<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageResultCopyWith<T, $Res> {
  factory $PageResultCopyWith(
    PageResult<T> value,
    $Res Function(PageResult<T>) then,
  ) = _$PageResultCopyWithImpl<T, $Res, PageResult<T>>;
  @useResult
  $Res call({
    List<T> content,
    int totalElements,
    int totalPages,
    int number,
    int size,
    bool first,
    bool last,
  });
}

/// @nodoc
class _$PageResultCopyWithImpl<T, $Res, $Val extends PageResult<T>>
    implements $PageResultCopyWith<T, $Res> {
  _$PageResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PageResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? totalElements = null,
    Object? totalPages = null,
    Object? number = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
  }) {
    return _then(
      _value.copyWith(
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            totalElements: null == totalElements
                ? _value.totalElements
                : totalElements // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            size: null == size
                ? _value.size
                : size // ignore: cast_nullable_to_non_nullable
                      as int,
            first: null == first
                ? _value.first
                : first // ignore: cast_nullable_to_non_nullable
                      as bool,
            last: null == last
                ? _value.last
                : last // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PageResultImplCopyWith<T, $Res>
    implements $PageResultCopyWith<T, $Res> {
  factory _$$PageResultImplCopyWith(
    _$PageResultImpl<T> value,
    $Res Function(_$PageResultImpl<T>) then,
  ) = __$$PageResultImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({
    List<T> content,
    int totalElements,
    int totalPages,
    int number,
    int size,
    bool first,
    bool last,
  });
}

/// @nodoc
class __$$PageResultImplCopyWithImpl<T, $Res>
    extends _$PageResultCopyWithImpl<T, $Res, _$PageResultImpl<T>>
    implements _$$PageResultImplCopyWith<T, $Res> {
  __$$PageResultImplCopyWithImpl(
    _$PageResultImpl<T> _value,
    $Res Function(_$PageResultImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PageResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? totalElements = null,
    Object? totalPages = null,
    Object? number = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
  }) {
    return _then(
      _$PageResultImpl<T>(
        content: null == content
            ? _value._content
            : content // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        totalElements: null == totalElements
            ? _value.totalElements
            : totalElements // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        size: null == size
            ? _value.size
            : size // ignore: cast_nullable_to_non_nullable
                  as int,
        first: null == first
            ? _value.first
            : first // ignore: cast_nullable_to_non_nullable
                  as bool,
        last: null == last
            ? _value.last
            : last // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$PageResultImpl<T> extends _PageResult<T> {
  const _$PageResultImpl({
    final List<T> content = const [],
    this.totalElements = 0,
    this.totalPages = 0,
    this.number = 0,
    this.size = 20,
    this.first = false,
    this.last = false,
  }) : _content = content,
       super._();

  factory _$PageResultImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$PageResultImplFromJson(json, fromJsonT);

  final List<T> _content;
  @override
  @JsonKey()
  List<T> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  @JsonKey()
  final int totalElements;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int number;
  @override
  @JsonKey()
  final int size;
  @override
  @JsonKey()
  final bool first;
  @override
  @JsonKey()
  final bool last;

  @override
  String toString() {
    return 'PageResult<$T>(content: $content, totalElements: $totalElements, totalPages: $totalPages, number: $number, size: $size, first: $first, last: $last)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageResultImpl<T> &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.last, last) || other.last == last));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_content),
    totalElements,
    totalPages,
    number,
    size,
    first,
    last,
  );

  /// Create a copy of PageResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PageResultImplCopyWith<T, _$PageResultImpl<T>> get copyWith =>
      __$$PageResultImplCopyWithImpl<T, _$PageResultImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$PageResultImplToJson<T>(this, toJsonT);
  }
}

abstract class _PageResult<T> extends PageResult<T> {
  const factory _PageResult({
    final List<T> content,
    final int totalElements,
    final int totalPages,
    final int number,
    final int size,
    final bool first,
    final bool last,
  }) = _$PageResultImpl<T>;
  const _PageResult._() : super._();

  factory _PageResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$PageResultImpl<T>.fromJson;

  @override
  List<T> get content;
  @override
  int get totalElements;
  @override
  int get totalPages;
  @override
  int get number;
  @override
  int get size;
  @override
  bool get first;
  @override
  bool get last;

  /// Create a copy of PageResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PageResultImplCopyWith<T, _$PageResultImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
