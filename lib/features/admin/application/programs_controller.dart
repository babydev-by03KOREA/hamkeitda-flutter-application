import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';
import '../data/admin_providers.dart';
import '../data/programs_repository.dart';
import '../domain/program.dart';

final programsRepoProvider = Provider<ProgramsRepository>((ref) {
  final api = ref.read(adminApiProvider);
  return ProgramsRepository(api);
});

final programsProvider =
    AsyncNotifierProvider<ProgramsController, List<Program>>(
      ProgramsController.new,
    );

class ProgramsController extends AsyncNotifier<List<Program>> {
  @override
  Future<List<Program>> build() async {
    final fid = ref.watch(
      authControllerProvider.select((a) => a.valueOrNull?.facilityId),
    );

    if (fid == null) return <Program>[];

    final repo = ref.read(programsRepoProvider);
    return repo.fetchPrograms(fid);
  }

  Future<void> add({required String name, String? description}) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    final fid = user?.facilityId;
    if (fid == null) throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(programsRepoProvider);
      await repo.createProgram(
        facilityId: fid,
        name: name,
        description: description,
      );
      return repo.fetchPrograms(fid);
    });
  }

  Future<void> remove(int programId) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    final fid = user?.facilityId;
    if (fid == null) throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(programsRepoProvider);
      await repo.deleteProgram(facilityId: fid, programId: programId);
      return repo.fetchPrograms(fid);
    });
  }
}
