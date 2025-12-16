import 'dart:io';

// 런타임 플래그 (flutter run --dart-define 으로 제어)
const USE_MOCK = bool.fromEnvironment('USE_MOCK', defaultValue: true);
final API_BASE_URL = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://211.188.48.147:8080/api'
);
