import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';
import 'admin_counsel_api.dart';
import 'admin_counsel_repository.dart';

final adminCounselRepositoryProvider =
Provider<AdminCounselRepository>((ref) {
  final dio = ref.read(dioProvider);
  return AdminCounselRepository(AdminCounselApi(dio));
});