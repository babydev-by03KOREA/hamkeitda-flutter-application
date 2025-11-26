import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../generated/program_info.freezed.dart';
part '../../../generated/program_info.g.dart';

@freezed
class ProgramInfo with _$ProgramInfo {
  const factory ProgramInfo({
    required String title,
    String? summary,
  }) = _ProgramInfo;

  factory ProgramInfo.fromJson(Map<String, dynamic> json) =>
      _$ProgramInfoFromJson(json);
}
