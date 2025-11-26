import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../generated/required_doc.freezed.dart';
part '../../../generated/required_doc.g.dart';

@freezed
class RequiredDoc with _$RequiredDoc {
  const factory RequiredDoc({
    required String title,
    String? note,
    String? link,
  }) = _RequiredDoc;

  factory RequiredDoc.fromJson(Map<String, dynamic> json) =>
      _$RequiredDocFromJson(json);
}
