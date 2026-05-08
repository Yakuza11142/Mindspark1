import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageEncryption {
  static final _storage = const FlutterSecureStorage();
  
  static Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  static Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }
}