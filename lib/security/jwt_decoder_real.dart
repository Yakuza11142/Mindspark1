import 'dart:convert';

class JwtDecoderReal {
  static Map<String, dynamic> decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Invalid JWT');

    String payload = parts[1];
    String normalized = base64Url.normalize(payload);
    String resp = utf8.decode(base64Url.decode(normalized));
    
    return jsonDecode(resp);
  }

  static bool isTokenExpired(String token) {
    final payload = decodeToken(token);
    final exp = payload['exp'] as int;
    final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return DateTime.now().isAfter(expiryDate);
  }
}