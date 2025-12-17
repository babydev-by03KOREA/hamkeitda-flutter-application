import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';
import '../data/admin_providers.dart';
import '../data/documents_repository.dart';
import '../domain/necessary_document.dart';

final documentsRepoProvider = Provider<DocumentsRepository>((ref) {
  final api = ref.read(adminApiProvider);
  return DocumentsRepository(api);
});

final documentsProvider =
    AsyncNotifierProvider<DocumentsController, List<NecessaryDocument>>(
      DocumentsController.new,
    );

class DocumentsController extends AsyncNotifier<List<NecessaryDocument>> {
  @override
  Future<List<NecessaryDocument>> build() async {
    final user = ref.watch(authControllerProvider).valueOrNull;
    final fid = user?.facilityId;

    if (fid == null) return <NecessaryDocument>[];

    final repo = ref.read(documentsRepoProvider);
    return repo.fetchDocuments(fid);
  }

  Future<void> add({required String documentName, String? howToGet}) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    final fid = user?.facilityId;
    if (fid == null) throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(documentsRepoProvider);
      await repo.createDocument(
        facilityId: fid,
        documentName: documentName,
        howToGet: howToGet,
      );
      return repo.fetchDocuments(fid);
    });
  }

  Future<void> remove(int documentId) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    final fid = user?.facilityId;
    if (fid == null) {
      throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(documentsRepoProvider);
      await repo.deleteDocument(facilityId: fid, documentId: documentId);
      return repo.fetchDocuments(fid);
    });
  }
}
