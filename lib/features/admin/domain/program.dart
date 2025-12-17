import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/program.freezed.dart';
part '../../../generated/program.g.dart';

@freezed
class Program with _$Program {
  const factory Program({
    required int id,
    @Default('') String name, // title 대신 서버 필드명인 name으로 변경
    String? description,
    int? sortOrder,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);
}