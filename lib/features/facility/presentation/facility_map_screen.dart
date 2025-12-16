import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';
import 'package:hamkeitda_flutter/features/auth/domain/user.dart';
import 'package:hamkeitda_flutter/features/facility/presentation/facility_detail_screen.dart';
import '../../auth/presentation/service_type_screen.dart';
import '../application/facility_controller.dart';
import '../domain/facility.dart';

class FacilityMapScreen extends ConsumerStatefulWidget {
  static const route = '/facility';

  const FacilityMapScreen({super.key});

  @override
  ConsumerState<FacilityMapScreen> createState() => _FacilityMapScreenState();
}

class _FacilityMapScreenState extends ConsumerState<FacilityMapScreen> {
  GoogleMapController? _map;
  double _zoom = 14;

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(serviceTypeProvider);
    final facilities = ref.watch(facilityControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, _) {
            final auth = ref.watch(authControllerProvider);
            final user = auth.valueOrNull;

            return Text(
              user == null || user.role == UserRole.guest
                  ? '안녕하세요, 게스트님!'
                  : '시설 위치',
            );
          },
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final auth = ref.watch(authControllerProvider);
              final user = auth.valueOrNull;

              // Guest: 로그인
              if (user == null || user.role == UserRole.guest) {
                return TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/service-type',
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('로그인'),
                );
              }

              // 로그인 상태: 로그아웃
              return TextButton.icon(
                onPressed: () async {
                  await ref.read(authControllerProvider.notifier).signOut();

                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/service-type', (route) => false);
                },
                icon: const Icon(Icons.logout),
                label: const Text('로그아웃'),
              );
            },
          ),
        ],
      ),
      body: facilities.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('불러오는 중 오류: $e')),
        data: (list) => _MapAndList(
          facilities: list,
          zoom: _zoom,
          onZoomIn: () {
            setState(() => _zoom = (_zoom + 1).clamp(3, 21));
            _map?.moveCamera(CameraUpdate.zoomTo(_zoom));
          },
          onZoomOut: () {
            setState(() => _zoom = (_zoom - 1).clamp(3, 21));
            _map?.moveCamera(CameraUpdate.zoomTo(_zoom));
          },
          onMyLocation: () async {
            final pos = await ref
                .read(facilityControllerProvider.notifier)
                .currentPosition();
            _map?.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(pos.latitude, pos.longitude),
                15,
              ),
            );
          },
          mapBuilder: (context, initialPos) => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPos,
              zoom: _zoom,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            onMapCreated: (c) => _map = c,
            markers: list.map(_toMarker).toSet(),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: TextField(
          decoration: InputDecoration(
            hintText: '시설명 또는 서비스로 검색',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
          ),
          onSubmitted: (_) =>
              ref.read(facilityControllerProvider.notifier).refreshNearby(),
        ),
      ),
    );
  }

  Marker _toMarker(Facility f) => Marker(
    markerId: MarkerId(f.id),
    position: LatLng(f.lat, f.lng),
    infoWindow: InfoWindow(
      title: f.name,
      snippet:
          (f.phone ?? '') + (f.openHours != null ? ' • ${f.openHours}' : ''),
    ),
  );
}

class _MapAndList extends StatelessWidget {
  final List<Facility> facilities;
  final double zoom;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onMyLocation;
  final Widget Function(BuildContext, LatLng) mapBuilder;

  const _MapAndList({
    required this.facilities,
    required this.zoom,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onMyLocation,
    required this.mapBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final center = LatLng(facilities.first.lat, facilities.first.lng);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              SizedBox(height: 320, child: mapBuilder(context, center)),
              Positioned(
                right: 12,
                top: 12,
                child: _RoundBtn(icon: Icons.my_location, onTap: onMyLocation),
              ),
              Positioned(
                right: 12,
                top: 64,
                child: _RoundBtn(icon: Icons.add, onTap: onZoomIn),
              ),
              Positioned(
                right: 12,
                top: 112,
                child: _RoundBtn(icon: Icons.remove, onTap: onZoomOut),
              ),
              Positioned(left: 12, bottom: 12, child: _ZoomBadge(zoom: zoom)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text('근처 시설', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...facilities.map((f) => _FacilityTile(f)).toList(),
        const SizedBox(height: 8),
        ...facilities.map((f) => _FacilityCard(f)).toList(),
      ],
    );
  }
}

class _RoundBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    shape: const CircleBorder(),
    elevation: 2,
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(10), child: Icon(icon)),
    ),
  );
}

class _ZoomBadge extends StatelessWidget {
  final double zoom;

  const _ZoomBadge({required this.zoom});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.9),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text('줌: ${zoom.toStringAsFixed(0)}/21'),
  );
}

class _FacilityTile extends StatelessWidget {
  final Facility f;

  const _FacilityTile(this.f);

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(f.name, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(
      [
        if (f.phone != null) f.phone!,
        if (f.openHours != null) f.openHours!,
      ].join(' • '),
      style: const TextStyle(color: Color(0xFF6B7280)),
    ),
    onTap: () => Navigator.pushNamed(
      context,
      FacilityDetailScreen.route,
      arguments: f.id, // ← 시설 id 전달
    ),
  );
}

class _FacilityCard extends StatelessWidget {
  final Facility f;

  const _FacilityCard(this.f);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      shadowColor: Colors.black.withOpacity(0.05),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          FacilityDetailScreen.route,
          arguments: f.id,
        ),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  f.imageUrl ??
                      'https://placehold.co/100x100/EFEFEF/AAAAAA?text=Image',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  // 이미지 로딩 실패 시
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: const Color(0xFFEFEFEF),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상단 (제목 + 상세보기)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            f.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '상세보기',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // 중간 (설명)
                    Text(
                      f.description ?? '설명이 없습니다.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 하단 (시간, 전화번호)
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          f.openHours ?? '정보없음',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          f.phone ?? '정보없음',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
