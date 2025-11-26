// 폼 검증 로직 (이메일, 비밀번호 등)
class Validators {
  static String? required(String? v, {String label = '필수 항목'}) {
    if (v == null || v.trim().isEmpty) return '$label 입니다';
    return null;
  }

  static String? email(String? v) {
    if (required(v, label: '이메일') != null) return '이메일을 입력하세요';
    final ok = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+").hasMatch(v!.trim());
    return ok ? null : '이메일 형식이 올바르지 않아요';
  }

  static String? password(String? v) {
    if (required(v, label: '비밀번호') != null) return '비밀번호를 입력하세요';
    if ((v ?? '').length < 8) return '비밀번호는 8자 이상';
    return null;
  }
}