import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class QuantumKeyRotator {
  static Future<void> rotateDailyKey() async {
    final storage = const FlutterSecureStorage();
    String newKey = const Uuid().v4();
    await storage.write(key: 'daily_cipher_key', value: newKey);
    print("Local Cipher Key Rotated Successfully.");
  }
}