import 'dart:io';

import '../domain/facility_image.dart';
import 'admin_api.dart';

class FacilityImagesRepository {
  final AdminApi api;
  FacilityImagesRepository(this.api);

  dynamic _unwrap(dynamic res) {
    if (res is Map && res['data'] != null) return res['data'];
    return res;
  }

  Future<FacilityImage> upload({
    required int facilityId,
    required File file,
    bool isPrimary = false,
    String? caption,
  }) async {
    final res = await api.uploadFacilityImage(
      facilityId: facilityId,
      file: file,
      isPrimary: isPrimary,
      caption: caption,
    );

    final raw = _unwrap(res);

    // 서버가 {id,url,isPrimary,...} 또는 {data:{...}} 둘 다 대응
    final map = (raw as Map).cast<String, dynamic>();
    return FacilityImage.fromJson(map);
  }
}