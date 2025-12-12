import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/application/admin_controller.dart';
import 'package:hamkeitda_flutter/features/admin/presentation/admin_counsel_list_screen.dart';
import 'package:hamkeitda_flutter/features/admin/presentation/counsel_readonly_sheet.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_provider.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_detail.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_form_state.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final basic = ref.watch(adminBasicProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('복지시설 관리자 대시보드'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AdminCounselListScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/auth'),
            icon: const Icon(Icons.logout),
            label: const Text('로그아웃'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '안녕하세요, ${user?.name ?? '관리자'}님',
                style: const TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ),
      ),
      // [수정] body의 배경색을 탭 배경과 맞추어 스크롤 시 이질감 없도록 수정
      backgroundColor: const Color(0xFFF1F1F4),
      body: basic.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
        data: (s) => _AdminBody(state: s),
      ),
      // [추가] 스크린샷 하단의 '변경사항 저장' 버튼
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // 배경색을 흰색으로 설정
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: FilledButton(
            onPressed: () {
              // TODO: 모든 변경사항 저장 로직
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '변경사항 저장',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class _AdminBody extends ConsumerStatefulWidget {
  final AdminBasicState state;

  const _AdminBody({required this.state});

  @override
  ConsumerState<_AdminBody> createState() => _AdminBodyState();
}

class _AdminBodyState extends ConsumerState<_AdminBody>
    with TickerProviderStateMixin {
  late final TabController _tab;
  late AdminBasicState _s = widget.state;
  int _currentTabIndex = 0; // [추가] 현재 탭 인덱스 추적

  @override
  void initState() {
    super.initState();
    _s = widget.state;
    _tab = TabController(length: 4, vsync: this);
    // [추가] 탭 컨트롤러 리스너
    _tab.addListener(() {
      // 탭 인덱스가 변경될 때마다 setState를 호출하여 UI를 다시 그리도록 함
      if (_tab.indexIsChanging) {
        setState(() {
          _currentTabIndex = _tab.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tab.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // [수정] ListView의 패딩을 수정하여 하단 버튼 영역을 침범하지 않도록 함
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80), // 하단 패딩 추가
      children: [
        _Card(
          // [수정] 탭 카드와 구별하기 위해 상단 마진 제거
          margin: EdgeInsets.zero,
          title: '시설 기본 정보',
          subtitle: '이용자에게 표시될 시설 정보를 관리하세요',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TextField(
                label: '시설명',
                initial: _s.name,
                onChanged: (v) => _s = _s.copyWith(name: v),
              ),
              _TextField(
                label: '운영시간',
                initial: _s.openHours,
                onChanged: (v) => _s = _s.copyWith(openHours: v),
              ),
              _TextField(
                label: '전화번호',
                initial: _s.phone,
                onChanged: (v) => _s = _s.copyWith(phone: v),
              ),
              _TextField(
                label: '주소',
                initial: _s.address,
                onChanged: (v) => _s = _s.copyWith(address: v),
              ),
              _TextField(
                label: '시설 소개',
                initial: _s.description,
                maxLines: 4,
                onChanged: (v) => _s = _s.copyWith(description: v),
              ),
              const SizedBox(height: 12),
              // [수정] 스크린샷과 동일한 이미지 첨부 UI
              const Text(
                '시설 이미지',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 100, // 스크린샷 비율에 맞게 크기 조절
                      height: 100,
                      color: const Color(0xFFEFEFEF),
                      child: _s.imageUrl == null
                          ? const Icon(Icons.image_not_supported_outlined,
                          size: 40, color: Colors.black26)
                          : Image.network(_s.imageUrl!, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // [수정] 스크린샷과 동일한 '이미지 추가' 버튼 스타일
                  OutlinedButton.icon(
                    onPressed: () {
                      // TODO: 이미지 픽커 붙이기
                    },
                    icon: const Icon(Icons.upload_outlined, size: 20),
                    label: const Text('이미지 추가'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.black26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () =>
                      ref.read(adminBasicProvider.notifier).save(_s),
                  child: const Text('저장'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // [수정] 사용자님이 제공해주신 _Tabs 위젯 사용
        _Tabs(controller: _tab),

        // [수정] TabBarView 대신, 현재 인덱스에 맞는 위젯을 직접 렌더링
        // 이렇게 하면 ListView 내에서 동적인 높이 조절이 가능합니다.
        [
          const _TabRequiredDocs(),
          const _TabPrograms(),
          const _TabFees(),
          const _TabPosts(),
        ].elementAt(_currentTabIndex),
      ],
    );
  }
}

// [추가] 사용자님이 제공한 TabBar 위젯
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
          isScrollable: false, // 1. 스크롤 비활성화 (탭 크기 균등 배분)
          indicatorPadding: const EdgeInsets.all(4), // 2. (추천) 인디케이터에 여백 추가
          indicator: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24), // 3. 여백에 맞게 값 조절 (20~24 추천)
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

// [수정] _Card 위젯에 margin 속성 추가
class _Card extends StatelessWidget {
  final String title, subtitle;
  final Widget child;
  final EdgeInsetsGeometry margin; // [추가] 마진 속성

  const _Card({
    required this.title,
    required this.subtitle,
    required this.child,
    this.margin = const EdgeInsets.only(top: 12), // [추가] 기본 마진
  });

  @override
  Widget build(BuildContext context) => Container(
    margin: margin, // [수정] 마진 적용
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 16),
        child,
      ],
    ),
  );
}

// [수정] _TextField 위젯 (기존과 동일)
class _TextField extends StatelessWidget {
  final String label, initial;
  final int maxLines;
  final ValueChanged<String> onChanged;

  const _TextField({
    required this.label,
    required this.initial,
    required this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      controller: TextEditingController(text: initial),
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF4F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

// [추가] 탭 1: 필요 서류 위젯
class _TabRequiredDocs extends StatelessWidget {
  const _TabRequiredDocs();

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: '필요 서류 관리',
      subtitle: '시설 이용 시 필요한 서류와 안내사항을 관리하세요',
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: _TabInputTextField(hint: '서류명을 입력하세요'),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: _TabInputTextField(hint: '획득 방법 (선택사항)'),
              ),
              const SizedBox(width: 8),
              _AddButton(onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          // TODO: 이 부분은 향후 상태관리(State)를 통해 동적으로 리스트를 만드셔야 합니다.
          _ListItem(text: '운영허가증', onDelete: () {}),
          const SizedBox(height: 8),
          _ListItem(text: '관련 자격증', onDelete: () {}),
        ],
      ),
    );
  }
}

// [추가] 탭 2: 프로그램 위젯
class _TabPrograms extends StatelessWidget {
  const _TabPrograms();

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: '프로그램 관리',
      subtitle: '시설에서 제공하는 프로그램과 서비스를 관리하세요',
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: _TabInputTextField(hint: '프로그램명을 입력하세요'),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: _TabInputTextField(hint: '프로그램 설명 (선택.)'),
              ),
              const SizedBox(width: 8),
              _AddButton(onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          // TODO: 이 부분은 향후 상태관리(State)를 통해 동적으로 리스트를 만드셔야 합니다.
          _ListItem(text: '상담 서비스', onDelete: () {}),
          const SizedBox(height: 8),
          _ListItem(text: '교육 프로그램', onDelete: () {}),
        ],
      ),
    );
  }
}

// [추가] 탭 3: 이용료 위젯
class _TabFees extends StatelessWidget {
  const _TabFees();

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: '이용료 관리',
      subtitle: '시설 이용료와 서비스별 요금을 관리하세요',
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: _TabInputTextField(hint: '새 이용료 정보를 입력하세요'),
              ),
              const SizedBox(width: 8),
              _AddButton(onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          // TODO: 이 부분은 향후 상태관리(State)를 통해 동적으로 리스트를 만드셔야 합니다.
          _ListItem(text: '기본 상담: 무료', onDelete: () {}),
          const SizedBox(height: 8),
          _ListItem(text: '전문 서비스: 별도 협의', onDelete: () {}),
        ],
      ),
    );
  }
}

// [추가] 탭 4: 게시물 위젯
class _TabPosts extends StatelessWidget {
  const _TabPosts();

  @override
  Widget build(BuildContext context) {
    return _Card(
      title: '게시물 관리',
      subtitle: '시설 소식과 공지사항을 게시하여 이용자들에게 정보를 제공하세요',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _TabInputTextField(hint: '게시물 제목을 입력하세요'),
          const SizedBox(height: 10),
          const _TabInputTextField(
            hint: '게시물 내용을 입력하세요',
            maxLines: 5, // 스크린샷과 비슷하게 높이 조절
          ),
          const SizedBox(height: 12),
          // "이미지 첨부" 버튼
          OutlinedButton.icon(
            onPressed: () {
              // TODO: 이미지 픽커
            },
            icon: const Icon(Icons.upload_outlined, size: 20),
            label: const Text('이미지 첨부'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color(0xFFF4F4F6), // 스크린샷의 옅은 회색
              side: BorderSide.none, // 테두리 없음
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 10),
          // "게시물 등록" 버튼
          FilledButton.icon(
            onPressed: () {
              // TODO: 게시물 등록 로직
            },
            icon: const Icon(Icons.add, color: Colors.white, size: 20),
            label: const Text('게시물 등록'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black, // 스크린샷의 검은색
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '등록된 게시물',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          // TODO: 향후 게시물 목록이 없을 때만 표시
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                '등록된 게시물이 없습니다.',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
          // TODO: 게시물 목록이 있을 경우 _ListItem과 비슷한 위젯으로 렌더링
        ],
      ),
    );
  }
}

// [추가] 탭 내부의 입력 필드용 헬퍼 위젯
class _TabInputTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController? controller;

  const _TabInputTextField({
    required this.hint,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14), // 힌트 텍스트 크기 조절
        filled: true,
        fillColor: const Color(0xFFF4F4F6), // 스크린샷과 동일한 배경색
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        // 높이를 조절하기 위한 contentPadding
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

// [추가] 탭 내부의 검은색 '+' 추가 버튼용 헬퍼 위젯
class _AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.zero,
        minimumSize: const Size(48, 48), // 스크린샷의 정사각형 버튼
      ),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

// [추가] 탭 내부의 목록 아이템용 헬퍼 위젯 (X 버튼 포함)
class _ListItem extends StatelessWidget {
  final String text;
  final VoidCallback onDelete;

  const _ListItem({required this.text, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F1F4)), // 옅은 테두리
      ),
      child: Row(
        children: [
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onDelete,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}