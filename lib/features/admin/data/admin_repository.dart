import 'package:hamkeitda_flutter/features/admin/domain/admin_basic_state.dart';
import 'admin_api.dart';

class AdminRepository {
  final AdminApi api;
  AdminRepository(this.api);

  Future<AdminBasicState> getBasic(int facilityId) async {
    final json = await api.getBasic(facilityId);

    final data = (json['data'] as Map?)?.cast<String, dynamic>() ?? json;
    return AdminBasicState.fromJson(data);
  }

  Future<int> saveBasic(AdminBasicState s) async {
    final json = await api.saveBasic(s.toSaveBody());

    final data = (json['data'] as Map?)?.cast<String, dynamic>() ?? json;
    return (data['id'] as num).toInt();
  }

  Future<void> updateBasic(int facilityId, AdminBasicState s) async {
    await api.updateBasic(facilityId, s.toSaveBody());
  }
}