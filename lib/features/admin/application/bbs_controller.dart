import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_controller.dart';
import '../data/admin_providers.dart';
import '../data/bbs_repository.dart';
import '../domain/bbs_post.dart';

final bbsRepoProvider = Provider<BbsRepository>((ref) {
  final api = ref.read(adminApiProvider);
  return BbsRepository(api);
});

final bbsProvider =
    AsyncNotifierProvider<BbsListController, PageResult<BbsPost>>(
      BbsListController.new,
    );

class BbsListController extends AsyncNotifier<PageResult<BbsPost>> {
  static const _defaultSize = 20;

  @override
  Future<PageResult<BbsPost>> build() async {
    final fid = ref.watch(authControllerProvider).valueOrNull?.facilityId;
    if (fid == null) {
      return const PageResult<BbsPost>(
        content: [],
        number: 0,
        size: _defaultSize,
        totalPages: 0,
        totalElements: 0,
        last: true,
      );
    }

    final repo = ref.read(bbsRepoProvider);
    return repo.fetchBbs(facilityId: fid, page: 0, size: _defaultSize);
  }

  Future<void> create({
    required String title,
    required String content,
    File? imageFile,
    bool isPrimary = true,
    String? caption,
    bool isPinned = false,
  }) async {
    final fid = ref.read(authControllerProvider).valueOrNull?.facilityId;
    if (fid == null) throw Exception('시설 기본정보를 먼저 저장해 주세요. (facilityId 없음)');

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(bbsRepoProvider);

      final bbsId = await repo.createBbs(
        facilityId: fid,
        title: title,
        content: content,
        isPinned: isPinned,
      );

      if (imageFile != null) {
        await repo.uploadImage(
          facilityId: fid,
          bbsId: bbsId,
          file: imageFile,
          isPrimary: isPrimary,
          caption: caption,
        );
      }

      return repo.fetchBbs(facilityId: fid, page: 0, size: 20);
    });
  }

  Future<void> refresh() async {
    final fid = ref.read(authControllerProvider).valueOrNull?.facilityId;
    if (fid == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(bbsRepoProvider);
      return repo.fetchBbs(facilityId: fid, page: 0, size: _defaultSize);
    });
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.last) return;

    final fid = ref.read(authControllerProvider).valueOrNull?.facilityId;
    if (fid == null) return;

    final nextPage = current.number + 1;

    state = await AsyncValue.guard(() async {
      final repo = ref.read(bbsRepoProvider);
      final next = await repo.fetchBbs(
        facilityId: fid,
        page: nextPage,
        size: current.size,
      );

      return current.copyWith(
        content: [...current.content, ...next.content],
        number: next.number,
        last: next.last,
        totalPages: next.totalPages,
        totalElements: next.totalElements,
      );
    });
  }
}
