import 'dart:convert';

class JwtUtils {
  static Map<String, dynamic>? decodeToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }
      final payload = parts[1];
      final String normalized = base64Url.normalize(payload);
      final String resp = utf8.decode(base64Url.decode(normalized));
      return json.decode(resp);
    } catch (e) {
      return null;
    }
  }

  static String? getUserId(String token) {
    final payload = decodeToken(token);
    return payload?['id'] ?? payload?['_id'];
  }
}
