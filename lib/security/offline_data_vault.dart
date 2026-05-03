import 'package:hive_flutter/hive_flutter.dart';
class OfflineDataVault {
  static Future<void> init(List<int> encryptionKey) async {
    await Hive.openBox('secure_vault', encryptionCipher: HiveAesCipher(encryptionKey));
  }
}