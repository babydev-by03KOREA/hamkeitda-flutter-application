import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/facility_repository.dart';
import '../data/facility_api.dart';
import '../domain/facility.dart';
import 'package:geolocator/geolocator.dart';

final facilityRepositoryProvider = Provider<FacilityRepository>(
  (ref) => FacilityRepository(FacilityApi()),
);

class FacilityController extends AsyncNotifier<List<Facility>> {
  Position? _pos;

  @override
  Future<List<Facility>> build() async {
    await _ensurePermission();
    _pos = await Geolocator.getCurrentPosition();
    return ref
        .read(facilityRepositoryProvider)
        .fetchNearby(_pos!.latitude, _pos!.longitude);
  }

  Future<void> refreshNearby({double? radiusKm}) async {
    if (_pos == null) return;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(facilityRepositoryProvider)
          .fetchNearby(
            _pos!.latitude,
            _pos!.longitude,
            radiusKm: radiusKm ?? 3,
          ),
    );
  }

  Future<Position> currentPosition() async {
    await _ensurePermission();
    return Geolocator.getCurrentPosition();
  }

  Future<void> _ensurePermission() async {
    final enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return; // UI에서 안내 처리
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }
  }
}

final facilityControllerProvider =
    AsyncNotifierProvider<FacilityController, List<Facility>>(
      FacilityController.new,
    );
