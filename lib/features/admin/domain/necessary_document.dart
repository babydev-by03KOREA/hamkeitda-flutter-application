import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/necessary_document.freezed.dart';

part '../../../generated/necessary_document.g.dart';

@freezed
class NecessaryDocument with _$NecessaryDocument {
  const factory NecessaryDocument({
    required int id,

    // 서버: name
    @JsonKey(name: 'name') @Default('') String title,

    // 서버: howToGet
    @JsonKey(name: 'howToGet') String? howTo,

    @JsonKey(name: 'sortOrder') int? sortOrder,
  }) = _NecessaryDocument;

  factory NecessaryDocument.fromJson(Map<String, dynamic> json) =>
      _$NecessaryDocumentFromJson(json);
}
