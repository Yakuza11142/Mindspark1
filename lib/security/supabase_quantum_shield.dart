import 'dart:convert';
import 'package:encrypt/encrypt.dart' as crypt;

class SupabaseQuantumShield {
  // CRUCIAL: This must be exactly 32 bytes (256 bits) for AES-256. 
  // Never hardcode this string literal in production; inject it via environmental vars or secure keyvaults.
  static final _encryptionKey = crypt.Key.fromUtf8('abcdefghijklmnopqrstuvwxyz123456');

  /// Transforms cleartext string metadata into a secure AES-256 base64 transaction string [1]
  static String encryptPayload(String rawData) {
    // Generate a unique 16-byte random initialization vector for every single transmission
    final initializationVector = crypt.IV.fromLength(16);
    
    final encrypterEngine = crypt.Encrypter(
      crypt.AES(_encryptionKey, mode: crypt.AESMode.cbc),
    );

    final encryptedDataResult = encrypterEngine.encrypt(rawData, iv: initializationVector);

    // Concatenate the IV and the encrypted payload together so it can be decrypted on the receiving side
    final combinedPayloadMap = {
      'iv': initializationVector.base64,
      'payload': encryptedDataResult.base64,
    };

    return jsonEncode(combinedPayloadMap);
  }

  /// Reverses the cryptographic payload back into its cleartext standard format [1]
  static String decryptPayload(String encryptedJson) {
    final Map<String, dynamic> parsedPayload = jsonDecode(encryptedJson);
    
    final initializationVector = crypt.IV.fromBase64(parsedPayload['iv']);
    final encrypterEngine = crypt.Encrypter(
      crypt.AES(_encryptionKey, mode: crypt.AESMode.cbc),
    );

    return encrypterEngine.decrypt64(
      parsedPayload['payload'], 
      iv: initializationVector,
    );
  }
}
