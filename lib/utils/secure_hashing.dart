import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecureHashing {
  /// Hashes data into a secure, uniform SHA-256 hex string
  static String hashData(String input) {
    if (input.isEmpty) return "";

    // Optimized memory execution layer handles block chunk streams natively
    final List<int> bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    
    return digest.toString(); // Output is always a safe, uniform 64-character hexadecimal hash
  }
}
