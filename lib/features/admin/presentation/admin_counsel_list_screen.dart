import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/data/admin_counsel_provider.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_provider.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_form_state.dart';
import 'package:hamkeitda_flutter/features/admin/presentation/counsel_readonly_sheet.dart';
import 'package:hamkeitda_flutter/features/admin/application/admin_counsel_provider.dart';

class AdminCounselListScreen extends ConsumerStatefulWidget {
  static const route = '/admin/counsels';
  const AdminCounselListScreen({super.key});

  @override
  ConsumerState<AdminCounselListScreen> createState() => _AdminCounselListScreenState();
}

class _AdminCounselListScreenState extends ConsumerState<AdminCounselListScreen> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (!_scroll.hasClients) return;
      final max = _scroll.position.maxScrollExtent;
      final cur = _scroll.position.pixels;
      if (cur >= max - 200) {
        // 바닥 근처면 다음 페이지
        final user = ref.read(currentUserProvider);
        final facilityId = user?.facilityId;
        if (facilityId != null) {
          ref.read(counselPagingProvider(facilityId).notifier).fetchNext();
        }
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final facilityId = user?.facilityId;

    if (facilityId == null) {
      return const Scaffold(body: Center(child: Text('시설 정보가 없습니다.')));
    }

    final asyncState = ref.watch(counselPagingProvider(facilityId));

    return Scaffold(
      appBar: AppBar(title: const Text('상담 신청 내역')),
      body: asyncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (s) {
          if (s.items.isEmpty) return const Center(child: Text('상담 신청이 없습니다.'));

          return RefreshIndicator(
            onRefresh: () => ref.read(counselPagingProvider(facilityId).notifier).refresh(),
            child: ListView.separated(
              controller: _scroll,
              itemCount: s.items.length + 1, // 로딩 더보기 row
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (ctx, idx) {
                if (idx == s.items.length) {
                  if (s.isLast) return const SizedBox(height: 24);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: s.isLoadingMore
                          ? const CircularProgressIndicator()
                          : const Text('더 불러오는 중...'),
                    ),
                  );
                }

                final item = s.items[idx];

                return InkWell(
                  onTap: () {
                    final formState = CounselFormState.fromJson(item.answersJson);
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => CounselReadonlySheet(form: formState),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.applicantName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.applicantPhone ?? '번호 없음',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '#${item.id}',
                          style: const TextStyle(fontSize: 12, color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}