import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecurityManager {
  /// 🚀 Native SHA-256 Hashing Engine
  /// Turns raw inputs into an unreadable 64-character hex string.
  static String hashData(String rawInput) {
    if (rawInput.isEmpty) return '';

    final bytes = utf8.encode(rawInput);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
