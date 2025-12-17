import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/core/dio_provider.dart';
import '../domain/admin_counsel_models.dart';
import 'admin_counsel_api.dart';
import 'admin_counsel_repository.dart';

final adminCounselRepoProvider = Provider<AdminCounselRepository>((ref) {
  final dio = ref.read(dioProvider);
  return AdminCounselRepository(AdminCounselApi(dio));
});

class CounselPagingState {
  final int facilityId;
  final List<CounselNotification> items;
  final int page;
  final bool isLast;
  final int totalElements;
  final bool isLoadingMore;

  const CounselPagingState({
    required this.facilityId,
    required this.items,
    required this.page,
    required this.isLast,
    required this.totalElements,
    required this.isLoadingMore,
  });

  CounselPagingState copyWith({
    List<CounselNotification>? items,
    int? page,
    bool? isLast,
    int? totalElements,
    bool? isLoadingMore,
  }) {
    return CounselPagingState(
      facilityId: facilityId,
      items: items ?? this.items,
      page: page ?? this.page,
      isLast: isLast ?? this.isLast,
      totalElements: totalElements ?? this.totalElements,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final counselPagingProvider = AsyncNotifierProviderFamily<
    CounselPagingController,
    CounselPagingState,
    int>(CounselPagingController.new);

class CounselPagingController
    extends FamilyAsyncNotifier<CounselPagingState, int> {
  static const _pageSize = 20;

  @override
  Future<CounselPagingState> build(int facilityId) async {
    final repo = ref.read(adminCounselRepoProvider);
    final first = await repo.fetchPage(
      facilityId: facilityId,
      page: 0,
      size: _pageSize,
    );

    debugPrint('facilityId=$facilityId page=${first.number} total=${first.totalElements}');
    debugPrint('content.length=${first.content.length} ids=${first.content.map((e) => e.id).toList()}');

    return CounselPagingState(
      facilityId: facilityId,
      items: first.content,
      page: first.number,
      isLast: first.last,
      totalElements: first.totalElements,
      isLoadingMore: false,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build(arg));
  }

  Future<void> fetchNext() async {
    final s = state.valueOrNull;
    if (s == null) return;
    if (s.isLast || s.isLoadingMore) return;

    state = AsyncValue.data(s.copyWith(isLoadingMore: true));

    final repo = ref.read(adminCounselRepoProvider);
    final next = await repo.fetchPage(
      facilityId: arg,
      page: s.page + 1,
      size: _pageSize,
    );

    state = AsyncValue.data(
      s.copyWith(
        items: [...s.items, ...next.content],
        page: next.number,
        isLast: next.last,
        totalElements: next.totalElements,
        isLoadingMore: false,
      ),
    );
  }
}

/// 🔔 뱃지 숫자용(초간단)
final counselBadgeCountProvider = FutureProvider.family<int, int>((ref, facilityId) async {
  final repo = ref.read(adminCounselRepoProvider);
  final page = await repo.fetchPage(facilityId: facilityId, page: 0, size: 1);
  return page.totalElements;
});