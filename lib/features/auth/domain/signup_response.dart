import 'package:hamkeitda_flutter/features/auth/domain/register_result.dart';

class SignupResponse {
  final RegisterResult user;
  final String message;

  SignupResponse({required this.user, required this.message});
}