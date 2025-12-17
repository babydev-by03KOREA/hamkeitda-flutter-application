import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/bbs_post.freezed.dart';
part '../../../generated/bbs_post.g.dart';

@freezed
class BbsPost with _$BbsPost {
  const factory BbsPost({
    required int id,
    required String title,
    required String content,
    required bool isPinned,
    required String createdAt,
  }) = _BbsPost;

  factory BbsPost.fromJson(Map<String, dynamic> json) =>
      _$BbsPostFromJson(json);
}

@Freezed(genericArgumentFactories: true)
class PageResult<T> with _$PageResult<T> {
  const PageResult._();

  const factory PageResult({
    @Default([]) List<T> content,
    @Default(0) int totalElements,
    @Default(0) int totalPages,
    @Default(0) int number,
    @Default(20) int size,
    @Default(false) bool first,
    @Default(false) bool last,
  }) = _PageResult<T>;

  List<T> get items => content;

  factory PageResult.fromJson(
      Map<String, dynamic> json,
      T Function(Object?) fromJsonT,
      ) =>
      _$PageResultFromJson(json, fromJsonT);
}