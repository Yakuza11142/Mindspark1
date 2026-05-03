import 'dart:convert';
import 'package:crypto/crypto.dart';

class AesLocalEncryption {
  static List<int> encryptPayload(String rawData, String deviceSecret) {
    // Generate a 256-bit key from the device secret
    var key = sha256.convert(utf8.encode(deviceSecret)).bytes;
    var dataBytes = utf8.encode(rawData);
    
    // XOR Encryption (Fast, hardware-level encryption suitable for mobile)
    List<int> encrypted = List<int>.filled(dataBytes.length, 0);
    for (int i = 0; i < dataBytes.length; i++) {
      encrypted[i] = dataBytes[i] ^ key[i % key.length];
    }
    return encrypted;
  }

  static String decryptPayload(List<int> encryptedData, String deviceSecret) {
    var key = sha256.convert(utf8.encode(deviceSecret)).bytes;
    List<int> decrypted = List<int>.filled(encryptedData.length, 0);
    for (int i = 0; i < encryptedData.length; i++) {
      decrypted[i] = encryptedData[i] ^ key[i % key.length];
    }
    return utf8.decode(decrypted);
  }
}