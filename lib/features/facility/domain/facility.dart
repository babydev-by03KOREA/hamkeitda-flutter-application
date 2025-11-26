import 'package:freezed_annotation/freezed_annotation.dart';
part '../../../generated/facility.freezed.dart';
part '../../../generated/facility.g.dart';

//  dart run build_runner build
@freezed
class Facility with _$Facility {
  const factory Facility({
    required String id,
    required String name,
    String? phone,
    String? openHours, // 예: "09:00 - 18:00"
    String? imageUrl,
    required double lat,
    required double lng,
    required String description,
  }) = _Facility;
  factory Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);
}