// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/admin/domain/necessary_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NecessaryDocument _$NecessaryDocumentFromJson(Map<String, dynamic> json) {
  return _NecessaryDocument.fromJson(json);
}

/// @nodoc
mixin _$NecessaryDocument {
  int get id => throw _privateConstructorUsedError; // 서버: name
  @JsonKey(name: 'name')
  String get title => throw _privateConstructorUsedError; // 서버: howToGet
  @JsonKey(name: 'howToGet')
  String? get howTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'sortOrder')
  int? get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this NecessaryDocument to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NecessaryDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NecessaryDocumentCopyWith<NecessaryDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NecessaryDocumentCopyWith<$Res> {
  factory $NecessaryDocumentCopyWith(
    NecessaryDocument value,
    $Res Function(NecessaryDocument) then,
  ) = _$NecessaryDocumentCopyWithImpl<$Res, NecessaryDocument>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'name') String title,
    @JsonKey(name: 'howToGet') String? howTo,
    @JsonKey(name: 'sortOrder') int? sortOrder,
  });
}

/// @nodoc
class _$NecessaryDocumentCopyWithImpl<$Res, $Val extends NecessaryDocument>
    implements $NecessaryDocumentCopyWith<$Res> {
  _$NecessaryDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NecessaryDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? howTo = freezed,
    Object? sortOrder = freezed,
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
            howTo: freezed == howTo
                ? _value.howTo
                : howTo // ignore: cast_nullable_to_non_nullable
                      as String?,
            sortOrder: freezed == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NecessaryDocumentImplCopyWith<$Res>
    implements $NecessaryDocumentCopyWith<$Res> {
  factory _$$NecessaryDocumentImplCopyWith(
    _$NecessaryDocumentImpl value,
    $Res Function(_$NecessaryDocumentImpl) then,
  ) = __$$NecessaryDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'name') String title,
    @JsonKey(name: 'howToGet') String? howTo,
    @JsonKey(name: 'sortOrder') int? sortOrder,
  });
}

/// @nodoc
class __$$NecessaryDocumentImplCopyWithImpl<$Res>
    extends _$NecessaryDocumentCopyWithImpl<$Res, _$NecessaryDocumentImpl>
    implements _$$NecessaryDocumentImplCopyWith<$Res> {
  __$$NecessaryDocumentImplCopyWithImpl(
    _$NecessaryDocumentImpl _value,
    $Res Function(_$NecessaryDocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NecessaryDocument
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? howTo = freezed,
    Object? sortOrder = freezed,
  }) {
    return _then(
      _$NecessaryDocumentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        howTo: freezed == howTo
            ? _value.howTo
            : howTo // ignore: cast_nullable_to_non_nullable
                  as String?,
        sortOrder: freezed == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NecessaryDocumentImpl implements _NecessaryDocument {
  const _$NecessaryDocumentImpl({
    required this.id,
    @JsonKey(name: 'name') this.title = '',
    @JsonKey(name: 'howToGet') this.howTo,
    @JsonKey(name: 'sortOrder') this.sortOrder,
  });

  factory _$NecessaryDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$NecessaryDocumentImplFromJson(json);

  @override
  final int id;
  // 서버: name
  @override
  @JsonKey(name: 'name')
  final String title;
  // 서버: howToGet
  @override
  @JsonKey(name: 'howToGet')
  final String? howTo;
  @override
  @JsonKey(name: 'sortOrder')
  final int? sortOrder;

  @override
  String toString() {
    return 'NecessaryDocument(id: $id, title: $title, howTo: $howTo, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NecessaryDocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.howTo, howTo) || other.howTo == howTo) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, howTo, sortOrder);

  /// Create a copy of NecessaryDocument
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NecessaryDocumentImplCopyWith<_$NecessaryDocumentImpl> get copyWith =>
      __$$NecessaryDocumentImplCopyWithImpl<_$NecessaryDocumentImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NecessaryDocumentImplToJson(this);
  }
}

abstract class _NecessaryDocument implements NecessaryDocument {
  const factory _NecessaryDocument({
    required final int id,
    @JsonKey(name: 'name') final String title,
    @JsonKey(name: 'howToGet') final String? howTo,
    @JsonKey(name: 'sortOrder') final int? sortOrder,
  }) = _$NecessaryDocumentImpl;

  factory _NecessaryDocument.fromJson(Map<String, dynamic> json) =
      _$NecessaryDocumentImpl.fromJson;

  @override
  int get id; // 서버: name
  @override
  @JsonKey(name: 'name')
  String get title; // 서버: howToGet
  @override
  @JsonKey(name: 'howToGet')
  String? get howTo;
  @override
  @JsonKey(name: 'sortOrder')
  int? get sortOrder;

  /// Create a copy of NecessaryDocument
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NecessaryDocumentImplCopyWith<_$NecessaryDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
