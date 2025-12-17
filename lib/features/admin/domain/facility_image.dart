import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/facility_image.freezed.dart';
part '../../../generated/facility_image.g.dart';

@freezed
class FacilityImage with _$FacilityImage {
  const factory FacilityImage({
    required int id,
    required String url,
    required bool isPrimary,
    String? caption,
    @Default(0) int sortOrder,
  }) = _FacilityImage;

  factory FacilityImage.fromJson(Map<String, dynamic> json) =>
      _$FacilityImageFromJson(json);
}