import '../domain/necessary_document.dart';
import 'admin_api.dart';

class DocumentsRepository {
  final AdminApi api;

  DocumentsRepository(this.api);

  // GET /api/admin/{facilityId}/documents
  Future<List<NecessaryDocument>> fetchDocuments(int facilityId) async {
    final res = await api.getDocuments(facilityId);

    final rawList = res is Map && res['data'] != null ? res['data'] : res;

    if (rawList is! List) {
      throw Exception('서버 응답이 List가 아닙니다: $rawList');
    }

    return rawList
        .map((e) => NecessaryDocument.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  // POST /api/admin/{facilityId}/documents
  Future<int> createDocument({
    required int facilityId,
    required String documentName,
    String? howToGet,
    int? sortOrder,
  }) async {
    final body = <String, dynamic>{
      'documentName': documentName,
      if (howToGet != null && howToGet.isNotEmpty) 'howToGet': howToGet,
      if (sortOrder != null) 'sortOrder': sortOrder,
    };

    final json = await api.addDocument(facilityId, body);

    final data = (json is Map && json['data'] is Map)
        ? (json['data'] as Map).cast<String, dynamic>()
        : (json as Map).cast<String, dynamic>();

    return (data['id'] as num).toInt();
  }

  // DELETE /api/admin/{facilityId}/documents/{documentId}
  Future<void> deleteDocument({
    required int facilityId,
    required int documentId,
  }) async {
    await api.deleteDocument(facilityId, documentId);
  }
}
