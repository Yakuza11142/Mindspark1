import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureMigrator {
  // Moves Sparks from insecure SharedPrefs to SecureStorage
  static Future<void> migrate() async {
    final prefs = await SharedPreferences.getInstance();
    final secure = const FlutterSecureStorage();
    
    if (prefs.containsKey('sparks')) {
      int oldSparks = prefs.getInt('sparks') ?? 0;
      await secure.write(key: 'sec_sparks', value: oldSparks.toString());
      await prefs.remove('sparks'); // Delete insecure version
    }
  }
}