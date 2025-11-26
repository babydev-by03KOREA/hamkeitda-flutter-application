import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/data/admin_api.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_provider.dart';

@immutable
class AdminBasicState {
  final String name, openHours, phone, address, description;
  final String? imageUrl;

  const AdminBasicState({
    this.name = '',
    this.openHours = '',
    this.phone = '',
    this.address = '',
    this.description = '',
    this.imageUrl,
  });

  AdminBasicState copyWith({
    String? name,
    String? openHours,
    String? phone,
    String? address,
    String? description,
    String? imageUrl,
  }) => AdminBasicState(
    name: name ?? this.name,
    openHours: openHours ?? this.openHours,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
  );
}

final adminBasicProvider =
    StateNotifierProvider<AdminBasicController, AsyncValue<AdminBasicState>>((
      ref,
    ) {
      return AdminBasicController(ref);
    });

class AdminBasicController extends StateNotifier<AsyncValue<AdminBasicState>> {
  final Ref ref;

  AdminBasicController(this.ref) : super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final user = ref.read(currentUserProvider);
      final api = ref.read(adminApiProvider);
      final fid = user?.facilityId ?? 'f-admin';
      final data = await api.getFacilityForAdmin(fid);
      state = AsyncData(
        AdminBasicState(
          name: data['name'] ?? '',
          openHours: data['openHours'] ?? '',
          phone: data['phone'] ?? '',
          address: data['address'] ?? '',
          description: data['description'] ?? '',
          imageUrl: data['imageUrl'],
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> save(AdminBasicState s) async {
    final user = ref.read(currentUserProvider);
    final fid = user?.facilityId ?? 'f-admin';
    await ref.read(adminApiProvider).updateBasic(fid, {
      'name': s.name,
      'openHours': s.openHours,
      'phone': s.phone,
      'address': s.address,
      'description': s.description,
      'imageUrl': s.imageUrl,
    });
    state = AsyncData(s);
  }
}
