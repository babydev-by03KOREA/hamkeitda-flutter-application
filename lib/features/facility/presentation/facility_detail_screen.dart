import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/counsel/presentation/counsel_form_screen.dart';
import 'package:hamkeitda_flutter/features/facility/application/facility_detail_controller.dart';
import 'package:hamkeitda_flutter/features/facility/domain/facility_detail.dart';
import 'package:hamkeitda_flutter/features/facility/domain/fee_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/post_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/program_info.dart';
import 'package:hamkeitda_flutter/features/facility/domain/required_doc.dart';

class FacilityDetailScreen extends ConsumerStatefulWidget {
  static const route = '/facility/detail';
  final String id;

  const FacilityDetailScreen({super.key, required this.id});

  @override
  ConsumerState<FacilityDetailScreen> createState() =>
      _FacilityDetailScreenState();
}

class _FacilityDetailScreenState extends ConsumerState<FacilityDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab = TabController(length: 4, vsync: this);
  final _page = PageController();
  int _pageIndex = 0;

  // 더미 캐러셀 이미지
  final _images = const [
    'assets/images/facility/001.jpg',
    'assets/images/facility/002.jpg',
    'assets/images/facility/003.jpg',
  ];

  @override
  void initState() {
    super.initState();
    ref.read(facilityDetailControllerProvider.notifier).setId(widget.id);
  }

  @override
  void dispose() {
    _page.dispose();
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(facilityDetailControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('목록으로 돌아가기'),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (detail) => NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverToBoxAdapter(
              child: _HeaderCarousel(
                images: _images,
                page: _page,
                pageIndex: _pageIndex,
                onChanged: (i) => setState(() => _pageIndex = i),
              ),
            ),
            SliverToBoxAdapter(child: _HeaderInfo(detail: detail)),
            SliverToBoxAdapter(child: _Tabs(controller: _tab)),
          ],
          body: TabBarView(
            controller: _tab,
            children: [
              _DocsTab(detail.requiredDocs),
              _ProgramsTab(detail.programs),
              _FeesTab(detail.fees),
              _PostsTab(detail.posts),
            ],
          ),
        ),
      ),
      floatingActionButton: state.hasValue
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CounselFormScreen()),
              ),
              icon: const Icon(Icons.sms_outlined),
              label: const Text('상담 신청'),
            )
          : null,
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 상단 캐러셀
class _HeaderCarousel extends StatelessWidget {
  final List<String> images;
  final PageController page;
  final int pageIndex;
  final ValueChanged<int> onChanged;

  const _HeaderCarousel({
    required this.images,
    required this.page,
    required this.pageIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: PageView.builder(
                  controller: page,
                  itemCount: images.length,
                  onPageChanged: onChanged,
                  itemBuilder: (_, i) =>
                      Image.asset(images[i], fit: BoxFit.cover),
                ),
              ),
              // 인디케이터
              Positioned(
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: List.generate(images.length, (i) {
                      final active = i == pageIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 기본 정보 카드
class _HeaderInfo extends StatelessWidget {
  final FacilityDetail detail;

  const _HeaderInfo({required this.detail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              if (detail.description != null)
                Text(
                  detail.description!,
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
              const SizedBox(height: 16),
              _InfoRow(
                icon: Icons.schedule,
                text: '운영시간: ${detail.openHours ?? '-'}',
              ),
              _InfoRow(icon: Icons.call, text: '전화번호: ${detail.phone ?? '-'}'),
              _InfoRow(icon: Icons.place, text: '주소: ${detail.address ?? '-'}'),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 탭바
class _Tabs extends StatelessWidget {
  final TabController controller;

  const _Tabs({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TabBar(
          controller: controller,
          isScrollable: false,
          // 1. 스크롤 비활성화 (탭 크기 균등 배분)
          indicatorPadding: const EdgeInsets.all(4),
          // 2. (추천) 인디케이터에 여백 추가
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            // 3. 여백에 맞게 값 조절 (20~24 추천)
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6),
            ],
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          tabs: const [
            Tab(
              icon: Icon(Icons.description_outlined, size: 18),
              text: '필요한 서류',
            ),
            Tab(icon: Icon(Icons.extension, size: 18), text: '프로그램 소개'),
            Tab(icon: Icon(Icons.attach_money, size: 18), text: '이용 안내'),
            Tab(icon: Icon(Icons.chat_bubble_outline, size: 18), text: '게시물'),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 탭: 필요한 서류
class _DocsTab extends StatelessWidget {
  final List<RequiredDoc> items;

  const _DocsTab(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          '필요한 서류',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        const Text(
          '시설 이용을 위해 준비해야 할 서류들입니다. 파란색 서류명을 클릭하면 발급처를 확인할 수 있습니다.',
          style: TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 12),
        ...items.map((e) => _DocItem(e)).toList(),
      ],
    );
  }
}

class _DocItem extends StatelessWidget {
  final RequiredDoc doc;

  const _DocItem(this.doc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ${doc.title}',
                style: const TextStyle(
                  color: Color(0xFF2563EB),
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (doc.note != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    doc.note!,
                    style: const TextStyle(color: Color(0xFF1E40AF)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 탭: 프로그램 소개
class _ProgramsTab extends StatelessWidget {
  final List<ProgramInfo> items;

  const _ProgramsTab(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final p = items[i];
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.white,
          title: Text(
            p.title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: p.summary != null ? Text(p.summary!) : null,
        );
      },
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 탭: 이용 안내(요금)
class _FeesTab extends StatelessWidget {
  final List<FeeInfo> items;

  const _FeesTab(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final f = items[i];
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.white,
          leading: const Icon(Icons.payments_outlined),
          title: Text(
            f.item,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: f.note != null ? Text(f.note!) : null,
          trailing: Text(
            f.price,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        );
      },
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 탭: 게시물
class _PostsTab extends StatelessWidget {
  final List<PostInfo> items;

  const _PostsTab(this.items);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('등록된 게시물이 없습니다.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final p = items[i];
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          tileColor: Colors.white,
          leading: const Icon(Icons.article_outlined),
          title: Text(
            p.title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: p.preview != null ? Text(p.preview!) : null,
          onTap: () {}, // 필요 시 상세로
        );
      },
    );
  }
}
