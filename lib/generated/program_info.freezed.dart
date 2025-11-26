// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../features/facility/domain/program_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProgramInfo _$ProgramInfoFromJson(Map<String, dynamic> json) {
  return _ProgramInfo.fromJson(json);
}

/// @nodoc
mixin _$ProgramInfo {
  String get title => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;

  /// Serializes this ProgramInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramInfoCopyWith<ProgramInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramInfoCopyWith<$Res> {
  factory $ProgramInfoCopyWith(
    ProgramInfo value,
    $Res Function(ProgramInfo) then,
  ) = _$ProgramInfoCopyWithImpl<$Res, ProgramInfo>;
  @useResult
  $Res call({String title, String? summary});
}

/// @nodoc
class _$ProgramInfoCopyWithImpl<$Res, $Val extends ProgramInfo>
    implements $ProgramInfoCopyWith<$Res> {
  _$ProgramInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? summary = freezed}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProgramInfoImplCopyWith<$Res>
    implements $ProgramInfoCopyWith<$Res> {
  factory _$$ProgramInfoImplCopyWith(
    _$ProgramInfoImpl value,
    $Res Function(_$ProgramInfoImpl) then,
  ) = __$$ProgramInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? summary});
}

/// @nodoc
class __$$ProgramInfoImplCopyWithImpl<$Res>
    extends _$ProgramInfoCopyWithImpl<$Res, _$ProgramInfoImpl>
    implements _$$ProgramInfoImplCopyWith<$Res> {
  __$$ProgramInfoImplCopyWithImpl(
    _$ProgramInfoImpl _value,
    $Res Function(_$ProgramInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? summary = freezed}) {
    return _then(
      _$ProgramInfoImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgramInfoImpl implements _ProgramInfo {
  const _$ProgramInfoImpl({required this.title, this.summary});

  factory _$ProgramInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramInfoImplFromJson(json);

  @override
  final String title;
  @override
  final String? summary;

  @override
  String toString() {
    return 'ProgramInfo(title: $title, summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramInfoImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, summary);

  /// Create a copy of ProgramInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramInfoImplCopyWith<_$ProgramInfoImpl> get copyWith =>
      __$$ProgramInfoImplCopyWithImpl<_$ProgramInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramInfoImplToJson(this);
  }
}

abstract class _ProgramInfo implements ProgramInfo {
  const factory _ProgramInfo({
    required final String title,
    final String? summary,
  }) = _$ProgramInfoImpl;

  factory _ProgramInfo.fromJson(Map<String, dynamic> json) =
      _$ProgramInfoImpl.fromJson;

  @override
  String get title;
  @override
  String? get summary;

  /// Create a copy of ProgramInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramInfoImplCopyWith<_$ProgramInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
