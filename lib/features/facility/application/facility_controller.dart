import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';

import '../data/facility_api.dart';
import '../data/facility_repository.dart';
import '../domain/facility.dart';

/// 1) API provider
final facilityApiProvider = Provider<FacilityApi>((ref) {
  final dio = ref.read(dioProvider);
  return FacilityApi(dio: dio);
});

/// 2) Repository provider  (← 이게 없어서 Undefined 난 거임)
final facilityRepositoryProvider = Provider<FacilityRepository>((ref) {
  final api = ref.read(facilityApiProvider);
  return FacilityRepository(api);
});

/// 3) Controller provider
final facilityControllerProvider =
    AsyncNotifierProvider<FacilityController, List<Facility>>(
      FacilityController.new,
    );

class FacilityController extends AsyncNotifier<List<Facility>> {
  LatLng? currentCenter;
  int _radiusM = 3000;

  @override
  Future<List<Facility>> build() async {
    // 앱 시작 기본 지도 중심 (예: 성북구 종암동 근처)
    currentCenter ??= const LatLng(37.58994, 127.016749);
    return ref.read(facilityRepositoryProvider).fetchNearby(
      currentCenter!.latitude,
      currentCenter!.longitude,
      radiusKm: _radiusM / 1000.0,
    );
  }

  Future<void> refreshByCenter(LatLng center, {int radiusM = 3000}) async {
    currentCenter = center;
    _radiusM = radiusM;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(facilityRepositoryProvider).fetchNearby(
        center.latitude,
        center.longitude,
        radiusKm: radiusM / 1000.0,
      );
    });
  }

  Future<Position> currentPosition() async {
    await _ensurePermission();
    return Geolocator.getCurrentPosition();
  }

  Future<void> _ensurePermission() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return;

    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
  }
}
