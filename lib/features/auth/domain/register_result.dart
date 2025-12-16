class RegisterResult {
  final RegisterUser user;
  final String message;

  RegisterResult({required this.user, required this.message});

  factory RegisterResult.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] as Map?)?.cast<String, dynamic>() ?? {};
    final userJson = (data['user'] as Map?)?.cast<String, dynamic>();

    if (userJson == null) {
      throw Exception('회원가입 응답에 user가 없어요.');
    }

    return RegisterResult(
      user: RegisterUser.fromJson(userJson),
      message: (data['message'] as String?) ?? '회원가입이 완료되었습니다.',
    );
  }
}

class RegisterUser {
  final int id;
  final String email;
  final String nickname;
  final String role; // 서버 값 그대로 보관 (ROLE_FACILITY / ROLE_USER)

  RegisterUser({
    required this.id,
    required this.email,
    required this.nickname,
    required this.role,
  });

  factory RegisterUser.fromJson(Map<String, dynamic> json) => RegisterUser(
    id: (json['id'] as num).toInt(),
    email: (json['email'] as String?) ?? '',
    nickname: (json['nickname'] as String?) ?? '',
    role: (json['role'] as String?) ?? 'ROLE_USER',
  );
}