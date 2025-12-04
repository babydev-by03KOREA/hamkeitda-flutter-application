import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/counsel_form_state.dart';
import '../domain/help_level.dart';

final counselFormProvider =
StateNotifierProvider<CounselFormNotifier, CounselFormState>((ref) {
  return CounselFormNotifier();
});

class CounselFormNotifier extends StateNotifier<CounselFormState> {
  CounselFormNotifier() : super(CounselFormState.initial());

  void setName(String v) {
    state = state.copyWith(name: v);
  }

  void setPhone(String v) {
    state = state.copyWith(phone: v);
  }

  void setWriter(String v) => state = state.copyWith(writer: v);
  void setWriteDate(DateTime v) => state = state.copyWith(writeDate: v);
  void setHeight(String v) => state = state.copyWith(height: v);
  void setWeight(String v) => state = state.copyWith(weight: v);
  void setBirth(String v) => state = state.copyWith(birth: v);
  void setGender(String v) => state = state.copyWith(gender: v);
  void setGrade(String v) => state = state.copyWith(gradeNumber: v);

  void setAdl(String code, HelpLevel level) {
    final newAdl = Map<String, HelpLevel?>.from(state.adl)..[code] = level;
    state = state.copyWith(adl: newAdl);
  }

  // 3. 의사소통
  void setHearing(String code) =>
      state = state.copyWith(hearing: code);

  void setCommunication(String code) =>
      state = state.copyWith(communication: code);

  void setSpeech(String code) =>
      state = state.copyWith(speech: code);

  // 4. 영양상태
  void setTeethStatus(String code) =>
      state = state.copyWith(teethStatus: code);

  void toggleMealIssue(String code, bool checked) {
    final set = {...state.mealIssues};
    checked ? set.add(code) : set.remove(code);
    state = state.copyWith(mealIssues: set);
  }

  void setToolUse(String code) =>
      state = state.copyWith(toolUse: code);

  void setExcretion(String code) =>
      state = state.copyWith(excretion: code);

  // 5. 가족 및 환경 상태
  void setMaritalStatus(String code) =>
      state = state.copyWith(maritalStatus: code);

  void setSpouseStatus(String code) =>
      state = state.copyWith(spouseStatus: code);

  void setChildrenCount(String text) {
    final v = int.tryParse(text);
    state = state.copyWith(childrenCount: v);
  }

  void setHasCaregiver(bool v) =>
      state = state.copyWith(hasCaregiver: v);

  void setCaregiverRelation(String code) =>
      state = state.copyWith(caregiverRelation: code);

  void setCaregiverRelationEtc(String v) =>
      state = state.copyWith(caregiverRelationEtc: v);

  void setCaregiverEconomy(String code) =>
      state = state.copyWith(caregiverEconomy: code);

  void setLivingWith(String code) =>
      state = state.copyWith(livingWith: code);

  // 6. 자원이용 욕구
  void setReligion(String code) =>
      state = state.copyWith(religion: code);

  void setReligionEtc(String v) =>
      state = state.copyWith(religionEtc: v);

  void setMainHospital(String v) =>
      state = state.copyWith(mainHospital: v);

  void setMainHospitalTel(String v) =>
      state = state.copyWith(mainHospitalTel: v);

  void toggleCommunityResource(String code, bool checked) {
    final set = {...state.communityResources};
    checked ? set.add(code) : set.remove(code);
    state = state.copyWith(communityResources: set);
  }

  void setCommunityResourceEtc(String v) =>
      state = state.copyWith(communityResourceEtc: v);

  void toggleDisease(String code) {
    final next = <String>{...state.diseases};
    if (next.contains(code)) {
      next.remove(code);
    } else {
      next.add(code);
    }
    state = state.copyWith(diseases: next);
  }

  void reset() {
    state = CounselFormState.initial();
  }
}