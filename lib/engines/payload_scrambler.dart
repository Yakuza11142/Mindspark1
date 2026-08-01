import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PayloadScrambler {
  /// Encrypts and authenticates your map payload data safely into a base64 string
  static Future<String> scramble(Map<String, dynamic> data) async {
    try {
      final String jsonStr = jsonEncode(data);
      final List<int> bytes = utf8.encode(jsonStr);

      final String secretKey = dotenv.maybeGet('PAYLOAD_SECRET_KEY') ?? "FALLBACK_SECURE_CIPHER_KEY_32_BYTES_";
      final List<int> keyBytes = utf8.encode(secretKey.padRight(32).substring(0, 32));

      final SecretKey secretKeyObject = SecretKey(keyBytes);
      
      // Scoped local cipher prevents multi-threaded variable cross-contamination traps
      final AesGcm cipher = AesGcm.with256bits();
      final SecretBox secretBox = await cipher.encrypt(
        bytes,
        secretKey: secretKeyObject,
      );

      final List<int> combinedPayload = secretBox.concatenation();
      return base64Encode(combinedPayload);
    } catch (e) {
      return "";
    }
  }

  /// Decodes and decrypts an incoming scrambled base64 string block back into a valid Map
  static Future<Map<String, dynamic>?> unscramble(String base64EncryptedString) async {
    try {
      if (base64EncryptedString.isEmpty) return null;

      final List<int> combinedPayload = base64Decode(base64EncryptedString);
      final String secretKey = dotenv.maybeGet('PAYLOAD_SECRET_KEY') ?? "FALLBACK_SECURE_CIPHER_KEY_32_BYTES_";
      final List<int> keyBytes = utf8.encode(secretKey.padRight(32).substring(0, 32));

      final AesGcm cipher = AesGcm.with256bits();
      final SecretBox secretBox = SecretBox.fromConcatenation(
        combinedPayload,
        nonceLength: cipher.nonceLength,
        macLength: cipher.macAlgorithm.macLength,
      );

      final List<int> decryptedBytes = await cipher.decrypt(
        secretBox,
        secretKey: SecretKey(keyBytes),
      );

      final String jsonStr = utf8.decode(decryptedBytes);
      final dynamic decodedPayload = jsonDecode(jsonStr);
      
      // Explicit Map constructor satisfies strict type checkers under production lints
      if (decodedPayload is Map) {
        return Map<String, dynamic>.from(decodedPayload);
      }
      return null;
    } catch (e) {
      return null; 
    }
  }
}
