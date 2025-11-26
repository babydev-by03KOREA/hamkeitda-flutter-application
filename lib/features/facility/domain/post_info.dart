import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../generated/post_info.freezed.dart';
part '../../../generated/post_info.g.dart';

@freezed
class PostInfo with _$PostInfo {
  const factory PostInfo({
    required String id,
    required String title,
    String? preview,
  }) = _PostInfo;

  factory PostInfo.fromJson(Map<String, dynamic> json) =>
      _$PostInfoFromJson(json);
}
