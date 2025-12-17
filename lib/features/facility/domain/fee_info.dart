import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/fee_info.freezed.dart';
part '../../../generated/fee_info.g.dart';

@freezed
class FeeInfo with _$FeeInfo {
  const factory FeeInfo({
    @Default('') String item,
    @Default('') String price,
    String? note,
  }) = _FeeInfo;

  factory FeeInfo.fromJson(Map<String, dynamic> json) => _$FeeInfoFromJson(json);
}
