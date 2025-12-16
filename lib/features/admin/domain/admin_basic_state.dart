import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/admin_basic_state.freezed.dart';
part '../../../generated/admin_basic_state.g.dart';

@freezed
class AdminBasicState with _$AdminBasicState {
  const factory AdminBasicState({
    required String name,
    required String openHours,
    required String phone,
    required String address,
    required String description,
    String? imageUrl,
  }) = _AdminBasicState;

  factory AdminBasicState.fromJson(Map<String, dynamic> json) =>
      _$AdminBasicStateFromJson(json);
}