import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/fee.freezed.dart';
part '../../../generated/fee.g.dart';

@freezed
class Fee with _$Fee {
  const factory Fee({
    required int id,
    @Default('') String title,
    @JsonKey(name: 'feeText') @Default('') String feeText,
    @JsonKey(name: 'sortOrder') @Default(0) int sortOrder,
  }) = _Fee;

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);
}