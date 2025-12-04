import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamkeitda_flutter/features/counsel/application/counsel_form_notifier.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_form_state.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/counsel_request.dart';
import 'package:hamkeitda_flutter/features/counsel/domain/help_level.dart';
import 'package:hamkeitda_flutter/features/facility/application/facility_detail_controller.dart';

class CounselFormScreen extends ConsumerWidget {
  const CounselFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(counselFormProvider);
    final notifier = ref.read(counselFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('초기 상담지')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ─ 기본정보 ─
            _BasicHeaderSection(
              writer: form.writer,
              writeDate: form.writeDate,
              height: form.height,
              weight: form.weight,
              birth: form.birth,
              gender: form.gender,
              gradeNumber: form.gradeNumber,
              onWriterChanged: notifier.setWriter,
              onDateChanged: notifier.setWriteDate,
              onHeightChanged: notifier.setHeight,
              onWeightChanged: notifier.setWeight,
              onBirthChanged: notifier.setBirth,
              onGenderChanged: notifier.setGender,
              onGradeChanged: notifier.setGrade,
            ),
            const SizedBox(height: 16),

            // ─ 1. 신체상태 ─
            _AdlSection(adl: form.adl, onChanged: notifier.setAdl),
            const SizedBox(height: 16),

            // ─ 2. 질병상태 ─
            _DiseaseSection(
              selected: form.diseases,
              onToggle: notifier.toggleDisease,
            ),
            const SizedBox(height: 24),

            _Section3Communication(
              hearing: form.hearing,
              communication: form.communication,
              speech: form.speech,
              onHearingChanged: notifier.setHearing,
              onCommunicationChanged: notifier.setCommunication,
              onSpeechChanged: notifier.setSpeech,
            ),
            const SizedBox(height: 12),
            _Section4Nutrition(
              state: form,
              onTeethChanged: notifier.setTeethStatus,
              onMealIssueToggled: notifier.toggleMealIssue,
              onToolChanged: notifier.setToolUse,
              onExcretionChanged: notifier.setExcretion,
            ),
            const SizedBox(height: 12),
            _Section5Family(
              state: form,
              onMaritalChanged: notifier.setMaritalStatus,
              onSpouseChanged: notifier.setSpouseStatus,
              onChildrenChanged: notifier.setChildrenCount,
              onHasCaregiverChanged: notifier.setHasCaregiver,
              onCaregiverRelationChanged: notifier.setCaregiverRelation,
              onCaregiverRelationEtcChanged: notifier.setCaregiverRelationEtc,
              onEconomyChanged: notifier.setCaregiverEconomy,
              onLivingWithChanged: notifier.setLivingWith,
            ),
            const SizedBox(height: 12),
            _Section6Resources(
              state: form,
              onReligionChanged: notifier.setReligion,
              onReligionEtcChanged: notifier.setReligionEtc,
              onHospitalChanged: notifier.setMainHospital,
              onHospitalTelChanged: notifier.setMainHospitalTel,
              onResToggled: notifier.toggleCommunityResource,
              onResEtcChanged: notifier.setCommunityResourceEtc,
            ),

            ElevatedButton(
              onPressed: () async {
                final answersJson = jsonEncode(form.toJson());
                final req = CounselRequest(
                  applicantName: form.name,
                  applicantPhone: form.phone,
                  answers: answersJson,
                );

                await ref
                    .read(facilityDetailControllerProvider.notifier)
                    .submitConsult(req: req);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('상담 신청이 접수되었습니다.')),
                );
                notifier.reset();
              },
              child: const Text('제출하기'),
            ),
          ],
        ),
      ),
    );
  }
}

class _BasicHeaderSection extends StatelessWidget {
  const _BasicHeaderSection({
    required this.writer,
    required this.writeDate,
    required this.height,
    required this.weight,
    required this.birth,
    required this.gender,
    required this.gradeNumber,
    required this.onWriterChanged,
    required this.onDateChanged,
    required this.onHeightChanged,
    required this.onWeightChanged,
    required this.onBirthChanged,
    required this.onGenderChanged,
    required this.onGradeChanged,
  });

  final String writer;
  final DateTime? writeDate;
  final String height;
  final String weight;
  final String birth;
  final String gender;
  final String gradeNumber;

  final ValueChanged<String> onWriterChanged;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onHeightChanged;
  final ValueChanged<String> onWeightChanged;
  final ValueChanged<String> onBirthChanged;
  final ValueChanged<String> onGenderChanged;
  final ValueChanged<String> onGradeChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '초기 상담지 기본정보',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: '작성자'),
                    onChanged: onWriterChanged,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: TextEditingController(
                      text: writeDate?.toString().split(' ').first ?? '',
                    ),
                    decoration: const InputDecoration(labelText: '작성일'),
                    onTap: () async {
                      final selected = await showDatePicker(
                        context: context,
                        initialDate: writeDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selected != null) onDateChanged(selected);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: '키 (cm)'),
                    onChanged: onHeightChanged,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: '체중 (kg)'),
                    onChanged: onWeightChanged,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: '생년월일'),
                    onChanged: onBirthChanged,
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: '성별'),
                    onChanged: onGenderChanged,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextField(
              decoration: const InputDecoration(labelText: '인정번호 / 등급'),
              onChanged: onGradeChanged,
            ),
          ],
        ),
      ),
    );
  }
}

// 1. 신체상태
class _AdlSection extends StatelessWidget {
  const _AdlSection({required this.adl, required this.onChanged});

  final Map<String, HelpLevel?> adl;
  final void Function(String code, HelpLevel level) onChanged;

  @override
  Widget build(BuildContext context) {
    HelpLevel? v(String code) => adl[code];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. 신체상태(일상생활동작 수행능력)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              '○ 자립 / △ 부분 도움 / ✕ 완전 도움',
              style: TextStyle(fontSize: 12),
            ),
            const Divider(),
            AdlRow(
              label: '옷 벗고 입기',
              value: v('clothes'),
              onChanged: (lv) => onChanged('clothes', lv),
            ),
            AdlRow(
              label: '식사 하기',
              value: v('eat'),
              onChanged: (lv) => onChanged('eat', lv),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdlRow(
                  label: '옷 벗고 입기',
                  value: v('clothes'),
                  onChanged: (lv) => onChanged('clothes', lv),
                ),
                AdlRow(
                  label: '식사 하기',
                  value: v('eat'),
                  onChanged: (lv) => onChanged('eat', lv),
                ),
                AdlRow(
                  label: '일어나 앉기',
                  value: v('sitUp'),
                  onChanged: (lv) => onChanged('sitUp', lv),
                ),
                AdlRow(
                  label: '화장실 사용하기',
                  value: v('toilet'),
                  onChanged: (lv) => onChanged('toilet', lv),
                ),
                AdlRow(
                  label: '세수하기',
                  value: v('washFace'),
                  onChanged: (lv) => onChanged('washFace', lv),
                ),
                AdlRow(
                  label: '목욕하기',
                  value: v('bathe'),
                  onChanged: (lv) => onChanged('bathe', lv),
                ),
                AdlRow(
                  label: '옮겨 앉기',
                  value: v('transfer'),
                  onChanged: (lv) => onChanged('transfer', lv),
                ),
                AdlRow(
                  label: '대변 조절하기',
                  value: v('bowelControl'),
                  onChanged: (lv) => onChanged('bowelControl', lv),
                ),
                AdlRow(
                  label: '양치질 하기',
                  value: v('brushingTeeth'),
                  onChanged: (lv) => onChanged('brushingTeeth', lv),
                ),
                AdlRow(
                  label: '체위변경 하기',
                  value: v('positionChange'),
                  onChanged: (lv) => onChanged('positionChange', lv),
                ),
                AdlRow(
                  label: '방밖으로 나오기',
                  value: v('goOutside'),
                  onChanged: (lv) => onChanged('goOutside', lv),
                ),
                AdlRow(
                  label: '소변조절하기',
                  value: v('urineControl'),
                  onChanged: (lv) => onChanged('urineControl', lv),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AdlRow extends StatelessWidget {
  const AdlRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final HelpLevel? value;
  final ValueChanged<HelpLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget radio(String text, HelpLevel level) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<HelpLevel>(
          value: level,
          groupValue: value,
          onChanged: (v) => v != null ? onChanged(v) : null,
        ),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          radio('○', HelpLevel.independent),
          radio('△', HelpLevel.partial),
          radio('✕', HelpLevel.dependent),
        ],
      ),
    );
  }
}

// 2. 질병상태 (카테고리 하나 예시)
class _DiseaseSection extends StatelessWidget {
  const _DiseaseSection({required this.selected, required this.onToggle});

  final Set<String> selected;
  final void Function(String code) onToggle;

  @override
  Widget build(BuildContext context) {
    bool isOn(String code) => selected.contains(code);

    Widget chip(String code, String label) => FilterChip(
      label: Text(label),
      selected: isOn(code),
      onSelected: (_) => onToggle(code),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '2. 질병상태',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text('내분비·대사성', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('dm', '당뇨'),
                chip('thyroid', '갑상선질환'),
                chip('obesity', '비만'),
                chip('etcEndo', '기타'),
              ],
            ),

            // 소화기계
            const Text('소화기계', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('gi_gastritis', '위염'),
                chip('gi_gastric_ulcer', '위궤양'),
                chip('gi_duodenal_ulcer', '십이지궤양'),
                chip('gi_constipation', '변비'),
                chip('gi_cirrhosis', '간경변증'),
                chip('gi_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 순환기계
            const Text('순환기계', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('cv_hypertension', '고혈압'),
                chip('cv_hypotension', '저혈압'),
                chip('cv_angina', '협심증'),
                chip('cv_mi', '심근경색증'),
                chip('cv_cerebrovascular', '뇌혈관질환'),
                chip('cv_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 근골격계
            const Text('근골격계', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('ms_arthritis', '관절염'),
                chip('ms_lowback_sciatica', '요통, 좌골통'),
                chip('ms_spine_etc', '기타 척추질환'),
                chip('ms_osteoporosis', '골다공증'),
                chip('ms_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 신경계
            const Text('신경계', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('neuro_dementia', '치매'),
                chip('neuro_infarction', '뇌경색'),
                chip('neuro_parkinson', '파킨슨병'),
                chip('neuro_headache', '두통'),
                chip('neuro_other_pain', '두통외 통증'),
                chip('neuro_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 정신·행동장애
            const Text('정신·행동장애', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('psych_neurosis', '신경증'),
                chip('psych_depression', '우울증'),
                chip('psych_sleep', '수면장애'),
                chip('psych_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 호흡기계
            const Text('호흡기계', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('resp_tb', '폐결핵'),
                chip('resp_copd', '만성기관지염'),
                chip('resp_dyspnea', '호흡곤란'),
                chip('resp_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 눈·귀질환
            const Text('눈·귀질환', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('eye_ear_visual_impairment', '시각장애'),
                chip('eye_ear_hearing_loss', '난청'),
                chip('eye_ear_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 비뇨·생식기계
            const Text('비뇨·생식기계', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                chip('uro_prostate_enlarge', '전립선비대'),
                chip('uro_incontinence', '요실금'),
                chip('uro_chronic_cystitis', '만성방광염'),
                chip('uro_etc', '기타'),
              ],
            ),

            SizedBox(height: 8),

            // 만성신장질환
            const Text('만성신장질환', style: TextStyle(fontSize: 13)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [chip('renal_crf', '만성신부전증'), chip('renal_etc', '기타')],
            ),
          ],
        ),
      ),
    );
  }
}

class _Section3Communication extends StatelessWidget {
  const _Section3Communication({
    required this.hearing,
    required this.communication,
    required this.speech,
    required this.onHearingChanged,
    required this.onCommunicationChanged,
    required this.onSpeechChanged,
  });

  final String hearing;
  final String communication;
  final String speech;
  final ValueChanged<String> onHearingChanged;
  final ValueChanged<String> onCommunicationChanged;
  final ValueChanged<String> onSpeechChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '3. 의사소통',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ChoiceRow(
              label: '청취 능력',
              value: hearing,
              options: const [
                ('none', '들리는지 판단 불능'),
                ('almostNone', '거의 들리지 않는다'),
                ('canHear', '큰소리는 들을 수 있다'),
                ('normal', '정상'),
              ],
              onChanged: onHearingChanged,
            ),
            const SizedBox(height: 8),
            _ChoiceRow(
              label: '의사소통',
              value: communication,
              options: const [
                ('allUnderstand', '모두 이해하고 의사를 표현함'),
                ('mostly', '대부분 이해하고 의사를 표현함'),
                ('rarely', '거의 이해하지 못하고 의사전달 못함'),
                ('none', '전혀 의사소통 안됨'),
              ],
              onChanged: onCommunicationChanged,
            ),
            const SizedBox(height: 8),
            _ChoiceRow(
              label: '발음',
              value: speech,
              options: const [
                ('accurate', '정확하게 발음 가능'),
                ('slurred', '웅얼거리는 소리로만 한다'),
                ('none', '전혀 발음하지 못한다'),
              ],
              onChanged: onSpeechChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section4Nutrition extends StatelessWidget {
  const _Section4Nutrition({
    required this.state,
    required this.onTeethChanged,
    required this.onMealIssueToggled,
    required this.onToolChanged,
    required this.onExcretionChanged,
  });

  final CounselFormState state;
  final ValueChanged<String> onTeethChanged;
  final void Function(String, bool) onMealIssueToggled;
  final ValueChanged<String> onToolChanged;
  final ValueChanged<String> onExcretionChanged;

  @override
  Widget build(BuildContext context) {
    bool has(String code) => state.mealIssues.contains(code);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '4. 영양상태',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ChoiceRow(
              label: '치아 상태',
              value: state.teethStatus,
              options: const [
                ('good', '양호'),
                ('bad', '불량'),
                ('denture', '의치'),
                ('noTeeth', '잔존치아 없음'),
              ],
              onChanged: onTeethChanged,
            ),
            const SizedBox(height: 8),
            const Text('식사 시 문제점'),
            Wrap(
              spacing: 8,
              children: [
                _CheckChip(
                  label: '식욕저하',
                  checked: has('appetiteLow'),
                  onChanged: (v) => onMealIssueToggled('appetiteLow', v),
                ),
                _CheckChip(
                  label: '저작곤란',
                  checked: has('chewingDiff'),
                  onChanged: (v) => onMealIssueToggled('chewingDiff', v),
                ),
                _CheckChip(
                  label: '연하곤란',
                  checked: has('swallowDiff'),
                  onChanged: (v) => onMealIssueToggled('swallowDiff', v),
                ),
                _CheckChip(
                  label: '소화불량',
                  checked: has('indigestion'),
                  onChanged: (v) => onMealIssueToggled('indigestion', v),
                ),
                _CheckChip(
                  label: '구토',
                  checked: has('vomit'),
                  onChanged: (v) => onMealIssueToggled('vomit', v),
                ),
                _CheckChip(
                  label: '없음',
                  checked: has('none'),
                  onChanged: (v) => onMealIssueToggled('none', v),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _ChoiceRow(
              label: '도구 사용',
              value: state.toolUse,
              options: const [
                ('spoon', '숟가락'),
                ('chopsticks', '젓가락'),
                ('forkFinger', '포크/손가락'),
                ('impossible', '사용불가'),
              ],
              onChanged: onToolChanged,
            ),
            const SizedBox(height: 8),
            _ChoiceRow(
              label: '배설 양상',
              value: state.excretion,
              options: const [
                ('normal', '정상'),
                ('diarrhea', '설사'),
                ('constipation', '변비'),
                ('bloated', '복부팽만'),
              ],
              onChanged: onExcretionChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section5Family extends StatelessWidget {
  const _Section5Family({
    required this.state,
    required this.onMaritalChanged,
    required this.onSpouseChanged,
    required this.onChildrenChanged,
    required this.onHasCaregiverChanged,
    required this.onCaregiverRelationChanged,
    required this.onCaregiverRelationEtcChanged,
    required this.onEconomyChanged,
    required this.onLivingWithChanged,
  });

  final CounselFormState state;
  final ValueChanged<String> onMaritalChanged;
  final ValueChanged<String> onSpouseChanged;
  final ValueChanged<String> onChildrenChanged;
  final ValueChanged<bool> onHasCaregiverChanged;
  final ValueChanged<String> onCaregiverRelationChanged;
  final ValueChanged<String> onCaregiverRelationEtcChanged;
  final ValueChanged<String> onEconomyChanged;
  final ValueChanged<String> onLivingWithChanged;

  @override
  Widget build(BuildContext context) {
    final isCaregiverEtc = state.caregiverRelation == 'etc';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '5. 가족 및 환경 상태',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            _ChoiceRow(
              label: '결혼여부',
              value: state.maritalStatus,
              options: const [('married', '기혼'), ('single', '미혼')],
              onChanged: onMaritalChanged,
            ),
            const SizedBox(height: 8),

            _ChoiceRow(
              label: '배우자 생존여부',
              value: state.spouseStatus,
              options: const [
                ('alive', '생존'),
                ('dead', '사망'),
                ('none', '해당 없음'),
              ],
              onChanged: onSpouseChanged,
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                const SizedBox(
                  width: 80,
                  child: Text('자녀수', textAlign: TextAlign.left),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: '명',
                    ),
                    onChanged: onChildrenChanged,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                const Text('주수발자 여부'),
                const SizedBox(width: 8),
                Switch(
                  value: state.hasCaregiver,
                  onChanged: onHasCaregiverChanged,
                ),
              ],
            ),

            if (state.hasCaregiver) ...[
              const SizedBox(height: 8),
              const Text('주수발자 관계'),
              Wrap(
                spacing: 8,
                children: [
                  _RadioChip(
                    label: '배우자',
                    code: 'spouse',
                    groupValue: state.caregiverRelation,
                    onChanged: onCaregiverRelationChanged,
                  ),
                  _RadioChip(
                    label: '자녀',
                    code: 'child',
                    groupValue: state.caregiverRelation,
                    onChanged: onCaregiverRelationChanged,
                  ),
                  _RadioChip(
                    label: '자부',
                    code: 'daughterInLaw',
                    groupValue: state.caregiverRelation,
                    onChanged: onCaregiverRelationChanged,
                  ),
                  _RadioChip(
                    label: '사위',
                    code: 'sonInLaw',
                    groupValue: state.caregiverRelation,
                    onChanged: onCaregiverRelationChanged,
                  ),
                  _RadioChip(
                    label: '형제자매',
                    code: 'sibling',
                    groupValue: state.caregiverRelation,
                    onChanged: onCaregiverRelationChanged,
                  ),
                  _RadioChip(
                    label: '친척',
                    code: 'relative',
                    groupValue: state.caregiverRelation,
                    onChanged: onCaregiverRelationChanged,
                  ),
                  _RadioChip(
                    label: '기타',
                    code: 'etc',
                    groupValue: state.caregiverRelation,
                    onChanged: onCaregiverRelationChanged,
                  ),
                ],
              ),
              if (isCaregiverEtc)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: TextField(
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: '기타 관계 입력',
                    ),
                    onChanged: onCaregiverRelationEtcChanged,
                  ),
                ),
            ],

            const SizedBox(height: 12),
            _ChoiceRow(
              label: '주수발자 경제상태',
              value: state.caregiverEconomy,
              options: const [
                ('stable', '안정'),
                ('unstable', '불안정'),
                ('pension', '연금생활'),
                ('welfare', '생활보호'),
              ],
              onChanged: onEconomyChanged,
            ),

            const SizedBox(height: 12),
            _ChoiceRow(
              label: '동거인',
              value: state.livingWith,
              options: const [
                ('alone', '독거'),
                ('couple', '부부'),
                ('parents', '부모'),
                ('children', '자녀'),
                ('grandChildren', '손자녀'),
                ('relative', '친척'),
                ('friendNeighbor', '친구·이웃'),
              ],
              onChanged: onLivingWithChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section6Resources extends StatelessWidget {
  const _Section6Resources({
    required this.state,
    required this.onReligionChanged,
    required this.onReligionEtcChanged,
    required this.onHospitalChanged,
    required this.onHospitalTelChanged,
    required this.onResToggled,
    required this.onResEtcChanged,
  });

  final CounselFormState state;
  final ValueChanged<String> onReligionChanged;
  final ValueChanged<String> onReligionEtcChanged;
  final ValueChanged<String> onHospitalChanged;
  final ValueChanged<String> onHospitalTelChanged;
  final void Function(String, bool) onResToggled;
  final ValueChanged<String> onResEtcChanged;

  @override
  Widget build(BuildContext context) {
    bool has(String code) => state.communityResources.contains(code);
    final isReligionEtc = state.religion == 'etc';
    final isResEtc = has('etc');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '6. 자원이용 욕구',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            const Text('종교'),
            Wrap(
              spacing: 8,
              children: [
                _RadioChip(
                  label: '천주교',
                  code: 'catholic',
                  groupValue: state.religion,
                  onChanged: onReligionChanged,
                ),
                _RadioChip(
                  label: '기독교',
                  code: 'protestant',
                  groupValue: state.religion,
                  onChanged: onReligionChanged,
                ),
                _RadioChip(
                  label: '불교',
                  code: 'buddhism',
                  groupValue: state.religion,
                  onChanged: onReligionChanged,
                ),
                _RadioChip(
                  label: '기타',
                  code: 'etc',
                  groupValue: state.religion,
                  onChanged: onReligionChanged,
                ),
              ],
            ),
            if (isReligionEtc)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: '기타 종교명 입력',
                  ),
                  onChanged: onReligionEtcChanged,
                ),
              ),

            const SizedBox(height: 12),
            const Text('주이용 의료기관'),
            TextField(
              decoration: const InputDecoration(isDense: true, hintText: '기관명'),
              onChanged: onHospitalChanged,
            ),
            const SizedBox(height: 4),
            TextField(
              decoration: const InputDecoration(
                isDense: true,
                hintText: '전화번호',
              ),
              keyboardType: TextInputType.phone,
              onChanged: onHospitalTelChanged,
            ),

            const SizedBox(height: 12),
            const Text('지역사회 자원'),
            Wrap(
              spacing: 8,
              children: [
                _CheckChip(
                  label: '급식 및 도시락배달',
                  checked: has('mealDelivery'),
                  onChanged: (v) => onResToggled('mealDelivery', v),
                ),
                _CheckChip(
                  label: '이미용',
                  checked: has('beauty'),
                  onChanged: (v) => onResToggled('beauty', v),
                ),
                _CheckChip(
                  label: '주거개선사업',
                  checked: has('houseImprove'),
                  onChanged: (v) => onResToggled('houseImprove', v),
                ),
                _CheckChip(
                  label: '기타',
                  checked: has('etc'),
                  onChanged: (v) => onResToggled('etc', v),
                ),
              ],
            ),
            if (isResEtc)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: '기타 자원 내용 입력',
                  ),
                  onChanged: onResEtcChanged,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

typedef Option = (String, String);

class _ChoiceRow extends StatelessWidget {
  const _ChoiceRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<Option> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          children: options
              .map(
                (opt) => _RadioChip(
                  label: opt.$2,
                  code: opt.$1,
                  groupValue: value,
                  onChanged: onChanged,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _RadioChip extends StatelessWidget {
  const _RadioChip({
    required this.label,
    required this.code,
    required this.groupValue,
    required this.onChanged,
  });

  final String label;
  final String code;
  final String groupValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = code == groupValue;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onChanged(code),
    );
  }
}

class _CheckChip extends StatelessWidget {
  const _CheckChip({
    required this.label,
    required this.checked,
    required this.onChanged,
  });

  final String label;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: checked,
      onSelected: onChanged,
    );
  }
}
