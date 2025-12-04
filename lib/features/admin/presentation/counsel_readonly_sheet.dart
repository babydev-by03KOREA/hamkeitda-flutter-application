import 'package:flutter/material.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_form_state.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/help_level.dart';

class CounselReadonlySheet extends StatelessWidget {
  final CounselFormState form;

  const CounselReadonlySheet({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      builder: (ctx, scroll) {
        return Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SingleChildScrollView(
            controller: scroll,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const Text(
                  '초기 상담지',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                _basicInfoCard(),
                const SizedBox(height: 12),
                _adlCard(),
                const SizedBox(height: 12),
                _diseaseCard(),
                const SizedBox(height: 12),
                _communicationCard(),
                const SizedBox(height: 12),
                _nutritionCard(),
                const SizedBox(height: 12),
                _familyCard(),
                const SizedBox(height: 12),
                _resourceCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------- 공통 small helpers ----------

  String _helpSymbol(HelpLevel? lv) {
    if (lv == null) return '-';
    return switch (lv) {
      HelpLevel.independent => '○',
      HelpLevel.partial => '△',
      HelpLevel.dependent => '✕',
    };
  }

  HelpLevel? _adl(String key) => form.adl[key];

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  // ---------- 섹션 0: 기본정보 ----------

  Widget _basicInfoCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '기본 정보',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _infoRow('수급자성명', form.name),
          _infoRow('연락처', form.phone),
          _infoRow('작성자', form.writer),
          _infoRow(
            '작성일',
            form.writeDate != null
                ? form.writeDate!.toIso8601String().split('T').first
                : '',
          ),
          const SizedBox(height: 4),
          _infoRow('키(cm)', form.height),
          _infoRow('체중(kg)', form.weight),
          _infoRow('생년월일', form.birth),
          _infoRow('성별', form.gender),
          _infoRow('인정번호/등급', form.gradeNumber),
        ],
      ),
    );
  }

  // ---------- 1. 신체상태(ADL) ----------

  Widget _adlRow(String label, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Text(_helpSymbol(_adl(key)), style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _adlCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '1. 신체상태(일상생활동작 수행능력)',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          const Text(
            '○ 자립 / △ 부분 도움 / ✕ 완전 도움',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          _adlRow('옷 벗고 입기', 'clothes'),
          _adlRow('식사 하기', 'eat'),
          _adlRow('일어나 앉기', 'sit'),
          _adlRow('화장실 사용하기', 'toilet'),
          _adlRow('세수하기', 'washFace'),
          _adlRow('목욕하기', 'shower'),
          _adlRow('옮겨 앉기', 'transfer'),
          _adlRow('대변 조절하기', 'bowelControl'),
          _adlRow('양치질 하기', 'brushTeeth'),
          _adlRow('체위변경 하기', 'positionChange'),
          _adlRow('밖으로 나오기', 'outdoor'),
          _adlRow('소변조절하기', 'urineControl'),
        ],
      ),
    );
  }

  // ---------- 2. 질병상태 (diseases Set<String>) ----------

  // 코드 → 레이블 + 그룹
  static const Map<String, String> _diseaseLabels = {
    // 내분비·대사성
    'dm': '당뇨',
    'thyroid': '갑상선질환',
    'obesity': '비만',
    'endoEtc': '기타(내분비·대사성)',
    // 소화기계
    'ulcer': '위염',
    'gastricUlcer': '위궤양',
    'duodenalUlcer': '십이지장궤양',
    'constipation': '변비',
    'liverCirrhosis': '간경변증',
    'digestEtc': '기타(소화기계)',
    // … 필요한 코드 계속 추가 …
  };

  Widget _chipsGroup(String title, List<String> codesInGroup) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              for (final code in codesInGroup)
                if (_diseaseLabels.containsKey(code))
                  _SelectedChip(
                    label: _diseaseLabels[code]!,
                    selected: form.diseases.contains(code),
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _diseaseCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '2. 질병상태',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _chipsGroup('내분비·대사성', const ['dm', 'thyroid', 'obesity', 'endoEtc']),
          _chipsGroup('소화기계', const [
            'ulcer',
            'gastricUlcer',
            'duodenalUlcer',
            'constipation',
            'liverCirrhosis',
            'digestEtc',
          ]),
          // 순환기계 / 근골격계 / 신경계 … 그룹 계속 추가
        ],
      ),
    );
  }

  // ---------- 3. 의사소통 ----------

  String _hearingText() {
    switch (form.hearing) {
      case 'none':
        return '들리는지 판단 불능';
      case 'almostNone':
        return '거의 들리지 않는다';
      case 'canHear':
        return '큰소리는 들을 수 있다';
      case 'normal':
        return '정상(보청기 사용 포함)';
      default:
        return '-';
    }
  }

  String _commText() {
    switch (form.communication) {
      case 'allUnderstand':
        return '모든 이해하고 의사를 표현한다';
      case 'mostly':
        return '대부분 이해하고 의사를 표현한다';
      case 'rarely':
        return '거의 이해하지 못하고 의사를 전달하지 못한다';
      case 'none':
        return '전혀 의사소통이 어렵다';
      default:
        return '-';
    }
  }

  String _speechText() {
    switch (form.speech) {
      case 'accurate':
        return '정확하게 발음이 가능하다';
      case 'slurred':
        return '웅얼거리는 소리로만 한다';
      case 'none':
        return '전혀 발음하지 못한다';
      default:
        return '-';
    }
  }

  Widget _communicationCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '3. 의사소통',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _infoRow('청취 능력', _hearingText()),
          _infoRow('의사 소통', _commText()),
          _infoRow('발음', _speechText()),
        ],
      ),
    );
  }

  // ---------- 4. 영양상태 ----------

  String _teethText() {
    switch (form.teethStatus) {
      case 'good':
        return '양호';
      case 'bad':
        return '불량';
      case 'denture':
        return '의치';
      case 'noTeeth':
        return '잔존치아 없음';
      default:
        return '-';
    }
  }

  String _toolUseText() {
    switch (form.toolUse) {
      case 'spoon':
        return '숟가락';
      case 'chopsticks':
        return '젓가락';
      case 'forkFinger':
        return '포크/손가락';
      case 'impossible':
        return '사용불가';
      default:
        return '-';
    }
  }

  String _excretionText() {
    switch (form.excretion) {
      case 'normal':
        return '정상';
      case 'diarrhea':
        return '설사';
      case 'constipation':
        return '변비';
      case 'bloated':
        return '복부팽만';
      default:
        return '-';
    }
  }

  Widget _nutritionCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '4. 영양상태',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _infoRow('치아 상태', _teethText()),
          _infoRow('도구 사용', _toolUseText()),
          _infoRow('배설 양상', _excretionText()),
          const SizedBox(height: 4),
          Text(
            '식사 시 문제: '
            '${form.mealIssues.isEmpty ? '없음' : form.mealIssues.join(", ")}',
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  // ---------- 5. 가족 및 환경 상태 ----------

  // (코드는 길어져서 스위치만 몇 개 보여둠, 실제로는 위 패턴대로 매핑)
  String _maritalText() => form.maritalStatus == 'married' ? '기혼' : '미혼';

  String _spouseText() {
    switch (form.spouseStatus) {
      case 'alive':
        return '생존';
      case 'dead':
        return '사망';
      default:
        return '해당 없음';
    }
  }

  Widget _familyCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '5. 가족 및 환경 상태',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _infoRow('결혼 여부', _maritalText()),
          _infoRow('배우자 생존 여부', _spouseText()),
          _infoRow('자녀 수', form.childrenCount?.toString() ?? '0'),
          _infoRow('주수발자 여부', form.hasCaregiver ? '있음' : '없음'),
          _infoRow(
            '주수발자 관계',
            form.caregiverRelationEtc.isNotEmpty
                ? form.caregiverRelationEtc
                : form.caregiverRelation,
          ),
          _infoRow('주수발자 경제상태', form.caregiverEconomy),
          _infoRow('동거인', form.livingWith),
        ],
      ),
    );
  }

  // ---------- 6. 자원이용 욕구 ----------

  Widget _resourceCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '6. 자원이용 욕구',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _infoRow(
            '종교',
            form.religionEtc.isNotEmpty ? form.religionEtc : form.religion,
          ),
          _infoRow('주이용 의료기관', form.mainHospital),
          _infoRow('전화번호', form.mainHospitalTel),
          const SizedBox(height: 4),
          Text(
            '지역사회자원: '
            '${form.communityResources.isEmpty ? '없음' : form.communityResources.join(", ")}'
            '${form.communityResourceEtc.isNotEmpty ? " / 기타: ${form.communityResourceEtc}" : ""}',
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _SelectedChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _SelectedChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? Theme.of(context).colorScheme.primary.withOpacity(0.12)
        : Colors.grey.shade100;
    final border = selected
        ? Theme.of(context).colorScheme.primary
        : Colors.grey.shade300;
    final text = selected
        ? Theme.of(context).colorScheme.primary
        : Colors.grey.shade800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border),
      ),
      child: Text(label, style: TextStyle(fontSize: 12, color: text)),
    );
  }
}
