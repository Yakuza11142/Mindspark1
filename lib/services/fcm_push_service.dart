import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePushService {
  static final _supabase = Supabase.instance.client;

  static Future<void> initialize() async {
    final messaging = FirebaseMessaging.instance;

    // 1. Request permissions
    await messaging.requestPermission();

    // 2. Save/Update the token in your Supabase 'profiles' or 'devices' table
    final token = await messaging.getToken();
    if (token != null) {
      await _saveTokenToSupabase(token);
    }

    // 3. Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        print("Supabase-triggered Notification: ${message.notification!.title}");
        // Trigger your local UI/Overlay here
      }
    });

    // 4. Handle token refreshes
    messaging.onTokenRefresh.listen(_saveTokenToSupabase);
  }

  static Future<void> _saveTokenToSupabase(String token) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId != null) {
      // Upsert the token into a table named 'fcm_tokens'
      await _supabase.from('profiles').upsert({
        'id': userId,
        'fcm_token': token,
        'updated_at': DateTime.now().toIso8601String(),
      });
    }
  }

  static Future<String?> getDeviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
