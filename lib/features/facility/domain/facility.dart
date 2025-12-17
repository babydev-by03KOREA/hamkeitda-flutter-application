import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/facility.freezed.dart';
part '../../../generated/facility.g.dart';

@freezed
class Facility with _$Facility {
  const Facility._();

  const factory Facility({
    required int id, // MarkerId가 String이라 지금 코드와 맞춤
    required String name,
    required double lat,
    required double lng,

    String? phone,
    String? openHours,
    String? description,

    // 대표 1장 (지도 카드에서 사용)
    String? imageUrl,

    // 상세에서 여러장 (서버가 주면 받기)
    @Default(<String>[]) List<String> imageUrls,
  }) = _Facility;

  // 대표이미지 fallback: imageUrl 없으면 imageUrls 첫 장
  String? get primaryImage => imageUrl ?? (imageUrls.isNotEmpty ? imageUrls.first : null);

  factory Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);
}