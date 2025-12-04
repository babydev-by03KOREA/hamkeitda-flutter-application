import 'package:flutter/foundation.dart';
import 'help_level.dart';

@immutable
class CounselFormState {
  // --- 기존 필드들 ---
  final String name;
  final String phone;
  final String writer;
  final DateTime? writeDate;
  final String height;
  final String weight;
  final String birth;
  final String gender;
  final String gradeNumber;

  final Map<String, HelpLevel?> adl;
  final Set<String> diseases;

  // === 3. 의사소통 ===
  /// 청취 능력: none / almostNone / canHear / normal
  final String hearing;

  /// 의사소통: allUnderstand / mostly / rarely / none
  final String communication;

  /// 발음: accurate / slurred / none
  final String speech;

  // === 4. 영양상태 ===
  /// 치아 상태: good / bad / denture / noTeeth
  final String teethStatus;

  /// 식사 시 문제: 복수 선택 → code set
  final Set<String>
  mealIssues; // ex) appetiteLow, chewingDiff, swallowDiff, indigestion, vomit, none
  /// 도구 사용: spoon / chopsticks / forkFinger / impossible
  final String toolUse;

  /// 배설 양상: normal / diarrhea / constipation / bloated
  final String excretion;

  // === 5. 가족 및 환경 상태 ===
  final String maritalStatus; // married / single
  final String spouseStatus; // alive / dead / none
  final int? childrenCount; // 자녀 수
  final bool hasCaregiver; // 주수발자 여부
  final String
  caregiverRelation; // spouse / child / daughterInLaw / sonInLaw / sibling / relative / etc
  final String caregiverRelationEtc; // '기타'일 때 직접 입력
  final String caregiverEconomy; // stable / unstable / pension / welfare
  final String
  livingWith; // alone / couple / parents / children / grandChildren / relative / friendNeighbor

  // === 6. 자원이용 욕구 ===
  final String religion; // catholic / protestant / buddhism / etc / none
  final String religionEtc; // 기타 종교 이름
  final String mainHospital; // 주이용 의료기관명
  final String mainHospitalTel; // 전화번호
  final Set<String>
  communityResources; // mealDelivery / beauty / houseImprove / etc
  final String communityResourceEtc;

  const CounselFormState({
    // 기존 필드
    required this.name,
    required this.phone,
    required this.writer,
    required this.writeDate,
    required this.height,
    required this.weight,
    required this.birth,
    required this.gender,
    required this.gradeNumber,
    required this.adl,
    required this.diseases,
    // 3
    required this.hearing,
    required this.communication,
    required this.speech,
    // 4
    required this.teethStatus,
    required this.mealIssues,
    required this.toolUse,
    required this.excretion,
    // 5
    required this.maritalStatus,
    required this.spouseStatus,
    required this.childrenCount,
    required this.hasCaregiver,
    required this.caregiverRelation,
    required this.caregiverRelationEtc,
    required this.caregiverEconomy,
    required this.livingWith,
    // 6
    required this.religion,
    required this.religionEtc,
    required this.mainHospital,
    required this.mainHospitalTel,
    required this.communityResources,
    required this.communityResourceEtc,
  });

  factory CounselFormState.initial() {
    return CounselFormState(
      name: '',
      phone: '',
      writer: '',
      writeDate: DateTime.now(),
      height: '',
      weight: '',
      birth: '',
      gender: '',
      gradeNumber: '',
      adl: const <String, HelpLevel?>{},
      diseases: <String>{},

      hearing: '',
      communication: '',
      speech: '',

      teethStatus: '',
      mealIssues: <String>{},
      toolUse: '',
      excretion: '',

      maritalStatus: '',
      spouseStatus: '',
      childrenCount: null,
      hasCaregiver: false,
      caregiverRelation: '',
      caregiverRelationEtc: '',
      caregiverEconomy: '',
      livingWith: '',

      religion: '',
      religionEtc: '',
      mainHospital: '',
      mainHospitalTel: '',
      communityResources: <String>{},
      communityResourceEtc: '',
    );
  }

  CounselFormState copyWith({
    String? name,
    String? phone,
    String? writer,
    DateTime? writeDate,
    String? height,
    String? weight,
    String? birth,
    String? gender,
    String? gradeNumber,
    Map<String, HelpLevel?>? adl,
    Set<String>? diseases,
    String? hearing,
    String? communication,
    String? speech,
    String? teethStatus,
    Set<String>? mealIssues,
    String? toolUse,
    String? excretion,
    String? maritalStatus,
    String? spouseStatus,
    int? childrenCount,
    bool? hasCaregiver,
    String? caregiverRelation,
    String? caregiverRelationEtc,
    String? caregiverEconomy,
    String? livingWith,
    String? religion,
    String? religionEtc,
    String? mainHospital,
    String? mainHospitalTel,
    Set<String>? communityResources,
    String? communityResourceEtc,
  }) {
    return CounselFormState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      writer: writer ?? this.writer,
      writeDate: writeDate ?? this.writeDate,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birth: birth ?? this.birth,
      gender: gender ?? this.gender,
      gradeNumber: gradeNumber ?? this.gradeNumber,
      adl: adl ?? this.adl,
      diseases: diseases ?? this.diseases,
      hearing: hearing ?? this.hearing,
      communication: communication ?? this.communication,
      speech: speech ?? this.speech,
      teethStatus: teethStatus ?? this.teethStatus,
      mealIssues: mealIssues ?? this.mealIssues,
      toolUse: toolUse ?? this.toolUse,
      excretion: excretion ?? this.excretion,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      spouseStatus: spouseStatus ?? this.spouseStatus,
      childrenCount: childrenCount ?? this.childrenCount,
      hasCaregiver: hasCaregiver ?? this.hasCaregiver,
      caregiverRelation: caregiverRelation ?? this.caregiverRelation,
      caregiverRelationEtc: caregiverRelationEtc ?? this.caregiverRelationEtc,
      caregiverEconomy: caregiverEconomy ?? this.caregiverEconomy,
      livingWith: livingWith ?? this.livingWith,
      religion: religion ?? this.religion,
      religionEtc: religionEtc ?? this.religionEtc,
      mainHospital: mainHospital ?? this.mainHospital,
      mainHospitalTel: mainHospitalTel ?? this.mainHospitalTel,
      communityResources: communityResources ?? this.communityResources,
      communityResourceEtc: communityResourceEtc ?? this.communityResourceEtc,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'writer': writer,
      'writeDate': writeDate?.toIso8601String(),
      'height': height,
      'weight': weight,
      'birth': birth,
      'gender': gender,
      'gradeNumber': gradeNumber,
      'adl': adl.map((k, v) => MapEntry(k, v?.name)),
      'diseases': diseases.toList(),

      // 3 ~ 6
      'hearing': hearing,
      'communication': communication,
      'speech': speech,
      'teethStatus': teethStatus,
      'mealIssues': mealIssues.toList(),
      'toolUse': toolUse,
      'excretion': excretion,
      'maritalStatus': maritalStatus,
      'spouseStatus': spouseStatus,
      'childrenCount': childrenCount,
      'hasCaregiver': hasCaregiver,
      'caregiverRelation': caregiverRelation,
      'caregiverRelationEtc': caregiverRelationEtc,
      'caregiverEconomy': caregiverEconomy,
      'livingWith': livingWith,
      'religion': religion,
      'religionEtc': religionEtc,
      'mainHospital': mainHospital,
      'mainHospitalTel': mainHospitalTel,
      'communityResources': communityResources.toList(),
      'communityResourceEtc': communityResourceEtc,
    };
  }

  factory CounselFormState.fromJson(Map<String, dynamic> json) {
    HelpLevel? _parseHelp(dynamic v) {
      if (v == null) return null;
      final s = v.toString();
      // enum name 기준 (independent / partial / dependent)
      return HelpLevel.values.firstWhere(
        (e) => e.name == s,
        orElse: () => HelpLevel.independent,
      );
    }

    Map<String, HelpLevel?> _parseAdl(dynamic raw) {
      if (raw is Map) {
        return raw.map<String, HelpLevel?>(
          (key, value) => MapEntry(key.toString(), _parseHelp(value)),
        );
      }
      return <String, HelpLevel?>{};
    }

    Set<String> _parseSet(dynamic raw) {
      if (raw is List) {
        return raw.map((e) => e.toString()).toSet();
      }
      return <String>{};
    }

    DateTime? _parseDate(dynamic raw) {
      if (raw == null) return null;
      return DateTime.tryParse(raw.toString());
    }

    int? _parseInt(dynamic raw) {
      if (raw == null) return null;
      if (raw is int) return raw;
      if (raw is num) return raw.toInt();
      return int.tryParse(raw.toString());
    }

    bool _parseBool(dynamic raw) {
      if (raw is bool) return raw;
      if (raw == null) return false;
      final s = raw.toString().toLowerCase();
      return s == 'true' || s == '1' || s == 'y';
    }

    return CounselFormState(
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      writer: json['writer']?.toString() ?? '',
      writeDate: _parseDate(json['writeDate']),
      height: json['height']?.toString() ?? '',
      weight: json['weight']?.toString() ?? '',
      birth: json['birth']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      gradeNumber: json['gradeNumber']?.toString() ?? '',

      adl: _parseAdl(json['adl']),
      diseases: _parseSet(json['diseases']),

      hearing: json['hearing']?.toString() ?? '',
      communication: json['communication']?.toString() ?? '',
      speech: json['speech']?.toString() ?? '',

      teethStatus: json['teethStatus']?.toString() ?? '',
      mealIssues: _parseSet(json['mealIssues']),
      toolUse: json['toolUse']?.toString() ?? '',
      excretion: json['excretion']?.toString() ?? '',

      maritalStatus: json['maritalStatus']?.toString() ?? '',
      spouseStatus: json['spouseStatus']?.toString() ?? '',
      childrenCount: _parseInt(json['childrenCount']),
      hasCaregiver: _parseBool(json['hasCaregiver']),
      caregiverRelation: json['caregiverRelation']?.toString() ?? '',
      caregiverRelationEtc: json['caregiverRelationEtc']?.toString() ?? '',
      caregiverEconomy: json['caregiverEconomy']?.toString() ?? '',
      livingWith: json['livingWith']?.toString() ?? '',

      religion: json['religion']?.toString() ?? '',
      religionEtc: json['religionEtc']?.toString() ?? '',
      mainHospital: json['mainHospital']?.toString() ?? '',
      mainHospitalTel: json['mainHospitalTel']?.toString() ?? '',
      communityResources: _parseSet(json['communityResources']),
      communityResourceEtc: json['communityResourceEtc']?.toString() ?? '',
    );
  }
}
