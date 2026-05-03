import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
class VaultKeyManager {
  static Future<List<int>> getOrCreateKey() async {
    const secure = FlutterSecureStorage();
    String? key = await secure.read(key: 'hive_key');
    if (key == null) return base64Url.decode("GENERATED_SECURE_KEY_HERE");
    return base64Url.decode(key);
  }
}
