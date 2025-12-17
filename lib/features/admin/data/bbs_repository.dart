import 'dart:io';
import '../domain/bbs_post.dart';
import 'admin_api.dart';

class BbsRepository {
  final AdminApi api;
  BbsRepository(this.api);

  dynamic _unwrapData(dynamic res) {
    if (res is Map<String, dynamic>) return res['data'] ?? res;
    return res;
  }

  Future<PageResult<BbsPost>> fetchBbs({
    required int facilityId,
    int page = 0,
    int size = 20,
  }) async {
    final res = await api.getBbs(facilityId, page: page, size: size);
    final raw = _unwrapData(res);

    if (raw is! Map) throw Exception('Page 응답이 Map이 아님: $raw');

    final contentRaw = raw['content'];
    if (contentRaw is! List) throw Exception('content가 List가 아님: $contentRaw');

    final posts = contentRaw
        .map((e) => BbsPost.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return PageResult<BbsPost>(
      content: posts,
      number: (raw['number'] as num?)?.toInt() ?? page,
      size: (raw['size'] as num?)?.toInt() ?? size,
      totalPages: (raw['totalPages'] as num?)?.toInt() ?? 0,
      totalElements: (raw['totalElements'] as num?)?.toInt() ?? 0,
      last: raw['last'] == true,
    );
  }

  Future<int> createBbs({
    required int facilityId,
    required String title,
    required String content,
    bool isPinned = false,
  }) async {
    final json = await api.createBbs(facilityId, {
      'title': title,
      'content': content,
      'isPinned': isPinned,
    });

    final data = (json is Map && json['data'] is Map) ? json['data'] as Map : json;
    return (data['id'] as num).toInt();
  }

  Future<void> uploadImage({
    required int facilityId,
    required int bbsId,
    required File file,
    bool isPrimary = false,
    String? caption,
  }) async {
    await api.uploadBbsImage(
      facilityId: facilityId,
      bbsId: bbsId,
      file: file,
      isPrimary: isPrimary,
      caption: caption,
    );
  }
}