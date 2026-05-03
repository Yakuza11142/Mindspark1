import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class HardwareAuthService {
  static final _db = Supabase.instance.client;

  static Future<void> loginOrRegisterDevice() async {
    // 1. Get Hardware ID
    final deviceInfo = DeviceInfoPlugin();
    String hwId = "UNKNOWN";
    if (Platform.isAndroid) {
      hwId = (await deviceInfo.androidInfo).id;
    } else if (Platform.isIOS) {
      hwId = (await deviceInfo.iosInfo).identifierForVendor ?? "IOS";
    }

    // 2. Supabase Anonymous Login (No password needed)
    final session = _db.auth.currentSession;
    if (session == null) {
      await _db.auth.signInAnonymously();
    }

    // 3. Link Hardware ID to Database
    final user = _db.auth.currentUser;
    if (user != null) {
      await _db.from('device_profiles').upsert({
        'hardware_id': hwId,
        'user_id': user.id,
        'last_login': DateTime.now().toIso8601String(),
      });
      print("🔓 Hardware Authenticated: $hwId");
    }
  }
}