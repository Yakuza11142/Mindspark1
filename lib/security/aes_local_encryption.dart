import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as crypt;

class AesLocalEncryption {
  /// Transforms data into a secure AES-256 base64 string package containing an initialization vector
  static String encryptPayload(String rawData, String deviceSecret) {
    // 1. Generate a mathematically sound 256-bit (32-byte) key from your secret via SHA-256
    final keyBytes = sha256.convert(utf8.encode(deviceSecret)).bytes;
    final cryptKey = crypt.Key(Uint8List.fromList(keyBytes));

    // 2. Generate a random 128-bit (16-byte) Initialization Vector (IV).
    // An IV must NEVER be reused across different encryption runs.
    final cryptIv = crypt.IV.fromLength(16);

    // 3. Initialize the standard AES engine
    final encrypter = crypt.Encrypter(
      crypt.AES(cryptKey, mode: crypt.AESMode.cbc),
    );

    // 4. Encrypt the data payload
    final encryptedResult = encrypter.encrypt(rawData, iv: cryptIv);

    // 5. Package the IV and ciphertext together so it can be unpacked during decryption
    final transportPackage = {
      'iv': cryptIv.base64,
      'ciphertext': encryptedResult.base64,
    };

    return jsonEncode(transportPackage);
  }

  /// Reverses the AES-256 encryption back into cleartext data
  static String decryptPayload(String packedJson, String deviceSecret) {
    try {
      final Map<String, dynamic> dataPackage = jsonDecode(packedJson);
      
      final keyBytes = sha256.convert(utf8.encode(deviceSecret)).bytes;
      final cryptKey = crypt.Key(Uint8List.fromList(keyBytes));
      
      // Re-extract the original IV and ciphertext blocks from the metadata map
      final cryptIv = crypt.IV.fromBase64(dataPackage['iv']);
      final String ciphertext = dataPackage['ciphertext'];

      final encrypter = crypt.Encrypter(
        crypt.AES(cryptKey, mode: crypt.AESMode.cbc),
      );

      return encrypter.decrypt64(ciphertext, iv: cryptIv);
    } catch (e) {
      // Throws an exception or returns empty if keys do not match or file data is corrupted
      throw ArgumentError("Decryption failed: Invalid key or tampered data payload.");
    }
  }
}
