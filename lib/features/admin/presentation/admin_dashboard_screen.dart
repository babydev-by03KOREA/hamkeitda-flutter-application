import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/admin/application/admin_controller.dart';
import 'package:hamkeitda_flutter/features/admin/application/bbs_controller.dart';
import 'package:hamkeitda_flutter/features/admin/application/documents_controller.dart';
import 'package:hamkeitda_flutter/features/admin/application/facility_images_controller.dart';
import 'package:hamkeitda_flutter/features/admin/application/fees_controller.dart';
import 'package:hamkeitda_flutter/features/admin/application/programs_controller.dart';
import 'package:hamkeitda_flutter/features/admin/domain/admin_basic_state.dart';
import 'package:hamkeitda_flutter/features/auth/application/auth_provider.dart';
import 'package:hamkeitda_flutter/features/auth/domain/user.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/application/auth_controller.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<AdminBasicState>>(adminBasicProvider, (prev, next) {
      // 저장 성공/실패 토스트 처리 예시
      final prevWasLoading = prev?.isLoading ?? false;

      if (prevWasLoading && next.hasError) {
        final msg = next.error.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }

      if (prevWasLoading && next.hasValue) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('저장 완료!')));
      }
    });

    ref.listen(
      authControllerProvider.select((a) => a.valueOrNull?.facilityId),
      (prev, next) {
        if (prev != next && next != null) {
          ref.invalidate(adminBasicProvider);
          ref.invalidate(documentsProvider);
          ref.invalidate(programsProvider);
          ref.invalidate(feesProvider);
          ref.invalidate(bbsProvider);
        }
      },
    );

    final user = ref.watch(currentUserProvider);
    final basic = ref.watch(adminBasicProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('복지시설 관리자'),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final auth = ref.watch(authControllerProvider);
              final user = auth.valueOrNull;

              // Guest: 로그인
              if (user == null || user.role == UserRole.guest) {
                return TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/auth');
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('로그인'),
                );
              }

              // 로그인 상태: 로그아웃
              return TextButton.icon(
                onPressed: () async {
                  await ref.read(authControllerProvider.notifier).signOut();

                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('/service-type', (route) => false);
                },
                icon: const Icon(Icons.logout),
                label: const Text('로그아웃'),
              );
            },
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
  int _currentTabIndex = 0;
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    _s = widget.state;

    _tab = TabController(length: 4, vsync: this);
    _tab.addListener(() {
      if (_tab.indexIsChanging) setState(() => _currentTabIndex = _tab.index);
    });
  }

  @override
  void didUpdateWidget(covariant _AdminBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 서버에서 값이 새로 내려왔고, 아직 사용자가 수정 중이 아니면 폼을 덮어씌움
    if (!_dirty && oldWidget.state != widget.state) {
      setState(() => _s = widget.state);
    }
  }

  void _markDirty() {
    if (!_dirty) _dirty = true;
  }

  @override
  void dispose() {
    _tab.dispose(); // 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final basicAsync = ref.watch(adminBasicProvider);
    final isSaving = basicAsync.isLoading;

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
                onChanged: (v) {
                  _markDirty();
                  _s = _s.copyWith(name: v);
                },
              ),
              _TimeRangeField(
                label: '운영시간',
                openTime: _s.openTime,
                closedTime: _s.closedTime,
                onOpenChanged: (t) {
                  _markDirty();
                  setState(() => _s = _s.copyWith(openTime: t));
                },
                onClosedChanged: (t) {
                  _markDirty();
                  setState(() => _s = _s.copyWith(closedTime: t));
                },
              ),
              _TextField(
                label: '전화번호',
                initial: _s.phone,
                onChanged: (v) {
                  _markDirty();
                  _s = _s.copyWith(phone: v);
                },
              ),
              _TextField(
                label: '주소',
                initial: _s.address,
                onChanged: (v) {
                  _markDirty();
                  _s = _s.copyWith(address: v);
                },
              ),
              _TextField(
                label: '시설 소개',
                initial: _s.description,
                maxLines: 4,
                onChanged: (v) {
                  _markDirty();
                  _s = _s.copyWith(description: v);
                },
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: () =>
                      ref.read(adminBasicProvider.notifier).save(_s),
                  child: isSaving ? const Text('저장 중...') : const Text('저장'),
                ),
              ),
            ],
          ),
        ),
        _Card(
          title: '시설 이미지 업로드',
          subtitle: '이미지로 시설을 보여주세요 (여러 장 업로드 가능)',
          child: Consumer(
            builder: (context, ref, _) {
              final imagesAsync = ref.watch(facilityImagesProvider);

              Future<void> pickAndUpload() async {
                final picker = ImagePicker();

                // 여러장 선택
                final files = await picker.pickMultiImage(imageQuality: 85);
                if (files.isEmpty) return;

                final dartFiles = files.map((x) => File(x.path)).toList();

                try {
                  await ref
                      .read(facilityImagesProvider.notifier)
                      .uploadMany(
                        files: dartFiles,
                        makeFirstPrimary: true, // 첫 장은 대표로 올리고 싶으면 true
                      );

                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('이미지 업로드 완료!')));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('업로드 실패: $e')));
                }
              }

              return Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: imagesAsync.when(
                          loading: () => const SizedBox(
                            height: 100,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          error: (e, _) => SizedBox(
                            height: 100,
                            child: Center(child: Text('오류: $e')),
                          ),
                          data: (imgs) {
                            final urls = imgs.map((e) => e.url).toList();

                            if (urls.isEmpty) {
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      color: const Color(0xFFEFEFEF),
                                      child: const Icon(
                                        Icons.image_not_supported_outlined,
                                        size: 40,
                                        color: Colors.black26,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Expanded(
                                    child: Text(
                                      '아직 업로드된 이미지가 없어요',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              );
                            }

                            return SizedBox(
                              height: 100,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: urls.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, i) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      color: const Color(0xFFEFEFEF),
                                      child: Image.network(
                                        urls[i],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: pickAndUpload,
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
                ],
              );
            },
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

class _TimeRangeField extends StatelessWidget {
  final String label;
  final TimeOfDay openTime;
  final TimeOfDay closedTime;
  final ValueChanged<TimeOfDay> onOpenChanged;
  final ValueChanged<TimeOfDay> onClosedChanged;

  const _TimeRangeField({
    required this.label,
    required this.openTime,
    required this.closedTime,
    required this.onOpenChanged,
    required this.onClosedChanged,
  });

  String _fmt(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _pick(
    BuildContext context,
    TimeOfDay initial,
    ValueChanged<TimeOfDay> onPicked,
  ) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) {
        // iOS 느낌(휠) 원하면 아래처럼. 안원하면 builder 빼도 됨.
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {}, // 전체 탭은 막고 버튼으로만 열어도 됨
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pick(context, openTime, onOpenChanged),
                      child: Text('오픈 ${_fmt(openTime)}'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          _pick(context, closedTime, onClosedChanged),
                      child: Text('마감 ${_fmt(closedTime)}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${_fmt(openTime)} - ${_fmt(closedTime)}',
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
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
      key: ValueKey(label),
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
class _TabRequiredDocs extends ConsumerStatefulWidget {
  const _TabRequiredDocs();

  @override
  ConsumerState<_TabRequiredDocs> createState() => _TabRequiredDocsState();
}

class _TabRequiredDocsState extends ConsumerState<_TabRequiredDocs> {
  final _titleCtrl = TextEditingController();
  final _howToCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _howToCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docsAsync = ref.watch(documentsProvider);

    return _Card(
      title: '필요 서류 관리',
      subtitle: '시설 이용 시 필요한 서류와 안내사항을 관리하세요',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _TabInputTextField(
                  hint: '서류명을 입력하세요',
                  controller: _titleCtrl,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TabInputTextField(
                  hint: '획득 방법 (선택사항)',
                  controller: _howToCtrl,
                ),
              ),
              const SizedBox(width: 8),
              _AddButton(
                onPressed: () async {
                  final title = _titleCtrl.text.trim();
                  final howTo = _howToCtrl.text.trim();

                  if (title.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('서류명을 입력하세요')));
                    return;
                  }

                  try {
                    await ref
                        .read(documentsProvider.notifier)
                        .add(
                          documentName: title,
                          howToGet: howTo.isEmpty ? null : howTo,
                        );

                    _titleCtrl.clear();
                    _howToCtrl.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('추가 실패: $e')));
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          docsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('오류: $e'),
            ),
            data: (docs) {
              if (docs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    '등록된 서류가 없습니다.',
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              }

              return Column(
                children: docs.map((d) {
                  final text = d.howTo == null || d.howTo!.isEmpty
                      ? d.title
                      : '${d.title} · ${d.howTo}';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ListItem(
                      text: text,
                      onDelete: () async {
                        if (d.id <= 0) return;
                        try {
                          await ref
                              .read(documentsProvider.notifier)
                              .remove(d.id);
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('삭제 실패: $e')));
                        }
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

//  탭 2: 프로그램 위젯
class _TabPrograms extends ConsumerStatefulWidget {
  const _TabPrograms();

  @override
  ConsumerState<_TabPrograms> createState() => _TabProgramsState();
}

class _TabProgramsState extends ConsumerState<_TabPrograms> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final programsAsync = ref.watch(programsProvider);

    return _Card(
      title: '프로그램 관리',
      subtitle: '시설에서 제공하는 프로그램과 서비스를 관리하세요',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _TabInputTextField(
                  hint: '프로그램명을 입력하세요',
                  controller: _nameCtrl,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TabInputTextField(
                  hint: '프로그램 설명 (선택.)',
                  controller: _descCtrl,
                ),
              ),
              const SizedBox(width: 8),
              _AddButton(
                onPressed: () async {
                  final name = _nameCtrl.text.trim();
                  final desc = _descCtrl.text.trim();

                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('프로그램명을 입력하세요')),
                    );
                    return;
                  }

                  try {
                    await ref
                        .read(programsProvider.notifier)
                        .add(
                          name: name,
                          description: desc.isEmpty ? null : desc,
                        );

                    _nameCtrl.clear();
                    _descCtrl.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('추가 실패: $e')));
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          programsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('오류: $e'),
            ),
            data: (programs) {
              debugPrint('🟦 UI programs length = ${programs.length}');
              debugPrint('🟦 UI programs = $programs');
              if (programs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    '등록된 프로그램이 없습니다.',
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              }

              return Column(
                children: programs.map((p) {
                  final text = (p.description == null || p.description!.isEmpty)
                      ? p.name
                      : '${p.name} · ${p.description}';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ListItem(
                      text: text,
                      onDelete: () async {
                        if (p.id <= 0) return;
                        try {
                          await ref
                              .read(programsProvider.notifier)
                              .remove(p.id);
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('삭제 실패: $e')));
                        }
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// [추가] 탭 3: 이용료 위젯
class _TabFees extends ConsumerStatefulWidget {
  const _TabFees();

  @override
  ConsumerState<_TabFees> createState() => _TabFeesState();
}

class _TabFeesState extends ConsumerState<_TabFees> {
  final _titleCtrl = TextEditingController();
  final _feeTextCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _feeTextCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feesAsync = ref.watch(feesProvider);

    return _Card(
      title: '이용료 관리',
      subtitle: '시설 이용료와 서비스별 요금을 관리하세요',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _TabInputTextField(
                  hint: '항목명 (예: 기본 상담)',
                  controller: _titleCtrl,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _TabInputTextField(
                  hint: '이용료 (예: 무료/문의/10,000원)',
                  controller: _feeTextCtrl,
                ),
              ),
              const SizedBox(width: 8),
              _AddButton(
                onPressed: () async {
                  final title = _titleCtrl.text.trim();
                  final feeText = _feeTextCtrl.text.trim();

                  if (title.isEmpty || feeText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('항목명/이용료를 입력하세요')),
                    );
                    return;
                  }

                  try {
                    await ref
                        .read(feesProvider.notifier)
                        .add(title: title, feeText: feeText);
                    _titleCtrl.clear();
                    _feeTextCtrl.clear();
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('추가 실패: $e')));
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          feesAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: CircularProgressIndicator(),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('오류: $e'),
            ),
            data: (fees) {
              if (fees.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    '등록된 이용료가 없습니다.',
                    style: TextStyle(color: Colors.black54),
                  ),
                );
              }

              return Column(
                children: fees.map((f) {
                  final text = '${f.title} · ${f.feeText}';
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ListItem(
                      text: text,
                      onDelete: () async {
                        try {
                          await ref.read(feesProvider.notifier).remove(f.id);
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('삭제 실패: $e')));
                        }
                      },
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

// [추가] 탭 4: 게시물 위젯
class _TabPosts extends ConsumerStatefulWidget {
  const _TabPosts();

  @override
  ConsumerState<_TabPosts> createState() => _TabPostsState();
}

class _TabPostsState extends ConsumerState<_TabPosts> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  File? _imageFile;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final xfile = await picker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      setState(() => _imageFile = File(xfile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final bbsAsync = ref.watch(bbsProvider);

    return _Card(
      title: '게시물 관리',
      subtitle: '시설 소식과 공지사항을 게시하여 이용자들에게 정보를 제공하세요',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 제목
          _TabInputTextField(hint: '게시물 제목을 입력하세요', controller: _titleCtrl),
          const SizedBox(height: 10),

          /// 내용
          _TabInputTextField(
            hint: '게시물 내용을 입력하세요',
            maxLines: 5,
            controller: _contentCtrl,
          ),
          const SizedBox(height: 12),

          /// 이미지 선택
          OutlinedButton.icon(
            onPressed: _pickImage,
            icon: const Icon(Icons.upload_outlined, size: 20),
            label: Text(_imageFile == null ? '이미지 첨부' : '이미지 선택됨'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color(0xFFF4F4F6),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 10),

          /// 게시물 등록 버튼
          FilledButton.icon(
            onPressed: () async {
              final title = _titleCtrl.text.trim();
              final content = _contentCtrl.text.trim();

              if (title.isEmpty || content.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('제목과 내용을 입력하세요')));
                return;
              }

              try {
                await ref
                    .read(bbsProvider.notifier)
                    .create(
                      title: title,
                      content: content,
                      imageFile: _imageFile,
                    );

                _titleCtrl.clear();
                _contentCtrl.clear();
                setState(() => _imageFile = null);
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('등록 실패: $e')));
              }
            },
            icon: const Icon(Icons.add, color: Colors.white, size: 20),
            label: const Text('게시물 등록'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),

          /// 게시물 목록
          bbsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text('오류: $e'),
            ),
            data: (page) {
              final posts = page.items;

              if (posts.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: Text(
                      '등록된 게시물이 없습니다.',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                );
              }

              return Column(
                children: posts.map((p) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _ListItem(
                      text: p.title,
                      onDelete: () {}, // 삭제 요구사항 없음
                    ),
                  );
                }).toList(),
              );
            },
          ),
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
        hintStyle: const TextStyle(fontSize: 14),
        // 힌트 텍스트 크기 조절
        filled: true,
        fillColor: const Color(0xFFF4F4F6),
        // 스크린샷과 동일한 배경색
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        // 높이를 조절하기 위한 contentPadding
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
