import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/dio_provider.dart';
import 'admin_api.dart';
import 'admin_repository.dart';

final adminApiProvider = Provider<AdminApi>((ref) {
  final dio = ref.read(dioProvider);
  return AdminApi(dio: dio);
});

final adminRepositoryProvider = Provider<AdminRepository>((ref) {
  return AdminRepository(ref.read(adminApiProvider));
});
