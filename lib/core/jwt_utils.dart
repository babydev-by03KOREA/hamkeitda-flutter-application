import 'dart:convert';

Map<String, dynamic>? decodeJwtPayload(String token) {
  final parts = token.split('.');
  if (parts.length != 3) return null;

  final payload = parts[1];
  final normalized = base64Url.normalize(payload);
  final bytes = base64Url.decode(normalized);
  final jsonStr = utf8.decode(bytes);
  return json.decode(jsonStr) as Map<String, dynamic>;
}