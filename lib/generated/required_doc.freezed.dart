// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/facility/domain/required_doc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RequiredDoc _$RequiredDocFromJson(Map<String, dynamic> json) {
  return _RequiredDoc.fromJson(json);
}

/// @nodoc
mixin _$RequiredDoc {
  String get title => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  /// Serializes this RequiredDoc to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RequiredDoc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequiredDocCopyWith<RequiredDoc> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequiredDocCopyWith<$Res> {
  factory $RequiredDocCopyWith(
    RequiredDoc value,
    $Res Function(RequiredDoc) then,
  ) = _$RequiredDocCopyWithImpl<$Res, RequiredDoc>;
  @useResult
  $Res call({String title, String? note, String? link});
}

/// @nodoc
class _$RequiredDocCopyWithImpl<$Res, $Val extends RequiredDoc>
    implements $RequiredDocCopyWith<$Res> {
  _$RequiredDocCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequiredDoc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? note = freezed,
    Object? link = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            link: freezed == link
                ? _value.link
                : link // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequiredDocImplCopyWith<$Res>
    implements $RequiredDocCopyWith<$Res> {
  factory _$$RequiredDocImplCopyWith(
    _$RequiredDocImpl value,
    $Res Function(_$RequiredDocImpl) then,
  ) = __$$RequiredDocImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? note, String? link});
}

/// @nodoc
class __$$RequiredDocImplCopyWithImpl<$Res>
    extends _$RequiredDocCopyWithImpl<$Res, _$RequiredDocImpl>
    implements _$$RequiredDocImplCopyWith<$Res> {
  __$$RequiredDocImplCopyWithImpl(
    _$RequiredDocImpl _value,
    $Res Function(_$RequiredDocImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequiredDoc
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? note = freezed,
    Object? link = freezed,
  }) {
    return _then(
      _$RequiredDocImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        link: freezed == link
            ? _value.link
            : link // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequiredDocImpl implements _RequiredDoc {
  const _$RequiredDocImpl({required this.title, this.note, this.link});

  factory _$RequiredDocImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequiredDocImplFromJson(json);

  @override
  final String title;
  @override
  final String? note;
  @override
  final String? link;

  @override
  String toString() {
    return 'RequiredDoc(title: $title, note: $note, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequiredDocImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, note, link);

  /// Create a copy of RequiredDoc
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequiredDocImplCopyWith<_$RequiredDocImpl> get copyWith =>
      __$$RequiredDocImplCopyWithImpl<_$RequiredDocImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequiredDocImplToJson(this);
  }
}

abstract class _RequiredDoc implements RequiredDoc {
  const factory _RequiredDoc({
    required final String title,
    final String? note,
    final String? link,
  }) = _$RequiredDocImpl;

  factory _RequiredDoc.fromJson(Map<String, dynamic> json) =
      _$RequiredDocImpl.fromJson;

  @override
  String get title;
  @override
  String? get note;
  @override
  String? get link;

  /// Create a copy of RequiredDoc
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequiredDocImplCopyWith<_$RequiredDocImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
