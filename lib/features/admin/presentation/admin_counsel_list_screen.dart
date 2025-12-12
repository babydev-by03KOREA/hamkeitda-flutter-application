import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/application/admin_counsel_provider.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_provider.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_form_state.dart';
import 'package:hamkeitda_flutter/features/admin/presentation/counsel_readonly_sheet.dart';

class AdminCounselListScreen extends ConsumerWidget {
  const AdminCounselListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    // 시설 관리자 아니면 막기 (필요하면 적당히 바꿔도 됨)
    final facilityId = user?.facilityId;
    if (facilityId == null) {
      return const Scaffold(
        body: Center(child: Text('시설 정보가 없습니다.')),
      );
    }

    final asyncList = ref.watch(counselListProvider(facilityId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('상담 신청 내역'),
      ),
      body: asyncList.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('상담 신청이 없습니다.'));
          }
          return ListView.separated(
            itemCount: list.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (ctx, idx) {
              final detail = list[idx];

              return ListTile(
                title: Text(detail.applicantName),
                subtitle: Text(
                  detail.applicantPhone ?? '',
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: Text(
                  _formatDate(detail.createdAt),
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
                onTap: () {
                  // 🔥 여기서 우리가 만든 read-only sheet 호출
                  final formState =
                  CounselFormState.fromJson(detail.answersJson);

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => CounselReadonlySheet(form: formState),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '-';
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-'
        '${dt.day.toString().padLeft(2, '0')}';
  }
}