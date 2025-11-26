import '../domain/facility.dart';
import '../domain/facility_detail.dart';
import 'facility_api.dart';

class FacilityRepository {
  final FacilityApi api;

  FacilityRepository(this.api);

  Future<List<Facility>> fetchNearby(
    double lat,
    double lng, {
    double radiusKm = 3,
  }) async {
    final list = await api.fetchNearby(lat: lat, lng: lng, radiusKm: radiusKm);
    return list.map((e) => Facility.fromJson(e)).toList();
  }

  // features/facility/data/facility_repository.dart
  Future<FacilityDetail> fetchDetail(String id) async =>
      FacilityDetail.fromJson(await api.fetchDetail(id));
  Future<void> submitConsult(String id,String name,String phone,String message)=>
      api.submitConsult(id,name:name,phone:phone,message:message);

}
