import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecurityManager {
  /// Secure SHA-256 Hashing Engine with mandatory salting.
  /// Throws an [ArgumentError] if the rawInput is empty.
  static String hashPassword({required String rawInput, required String salt}) {
    // Prevent empty inputs from passing quietly
    if (rawInput.trim().isEmpty) {
      throw ArgumentError('Raw input cannot be empty or whitespace.');
    }
    if (salt.trim().isEmpty) {
      throw ArgumentError('A secure, unique salt must be provided.');
    }

    // Combine input with a unique salt to defeat rainbow tables
    final saltedInput = '$rawInput$salt';
    final bytes = utf8.encode(saltedInput);
    final digest = sha256.convert(bytes);
    
    return digest.toString();
  }
}
