import 'package:hamkeitda_flutter/features/admin/domain/admin_basic_state.dart';

import 'admin_api.dart';

class AdminRepository {
  final AdminApi api;

  AdminRepository(this.api);

  Future<AdminBasicState> getBasic(int facilityId) async {
    final json = await api.getBasic(facilityId);
    return AdminBasicState.fromJson(json);
  }

  Future<void> saveBasic(AdminBasicState s) async {
    await api.saveBasic(s.toJson());
  }

  Future<void> updateBasic(int facilityId, AdminBasicState s) async {
    await api.updateBasic(facilityId, s.toJson());
  }
}
