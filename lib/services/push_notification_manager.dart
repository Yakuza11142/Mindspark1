import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class PushNotificationManager {
  static final _supabase = Supabase.instance.client;

  static Future<void> init(String userId) async {
    try {
      if (kDebugMode) print("🔔 [PN Manager] Initializing...");

      // In a real app, use: String? token = await FirebaseMessaging.instance.getToken();
      String fakeToken = "dev_token_${userId.substring(0, 5)}";

      // Store token in Supabase 'profiles' table for targeting
      await _supabase.from('profiles').update({
        'fcm_token': fakeToken,
        'last_online': DateTime.now().toIso8601String(),
      }).eq('id', userId);

      if (kDebugMode) print("✅ [PN Manager] Token synced to Supabase for user: $userId");
    } catch (e) {
      if (kDebugMode) print("❌ [PN Manager] Debug Error: $e");
    }
  }
}
