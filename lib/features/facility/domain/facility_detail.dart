import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamkeitda_flutter/features/facility/domain/fee_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/post_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/program_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/required_doc.dart';

part '../../../generated/facility_detail.freezed.dart';

part '../../../generated/facility_detail.g.dart';

@freezed
class FacilityDetail with _$FacilityDetail {
  const factory FacilityDetail({
    required String id,
    required String name,
    String? description,
    String? phone,
    String? openHours,
    String? address,
    String? imageUrl,
    @Default([]) List<RequiredDoc> requiredDocs,
    @Default([]) List<ProgramInfo> programs,
    @Default([]) List<FeeInfo> fees,
    @Default([]) List<PostInfo> posts,
  }) = _FacilityDetail;

  factory FacilityDetail.fromJson(Map<String, dynamic> json) =>
      _$FacilityDetailFromJson(json);
}
