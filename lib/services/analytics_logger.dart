import 'package:supabase_flutter/supabase_flutter.dart';

class AnalyticsLogger {
  // Get the Supabase client instance
  static final _supabase = Supabase.instance.client;

  static Future<void> logEvent(String name, {Map<String, dynamic>? metadata}) async {
    // 1. Keep the debug print
    print("LOGGING EVENT: $name");

    try {
      // 2. Log to Supabase "logs" table
      // We use a Map to make it non-hardcoded so you can pass any extra data
      await _supabase.from('logs').insert({
        'event_name': name,
        'metadata': metadata ?? {}, // Any extra info like user_id or screen_name
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // 3. Debugging: Catch connection or table errors
      print("Supabase logging failed: $e");
    }
  }
}
// Simple log
AnalyticsLogger.logEvent("certificate_downloaded");

// Detailed log (non-hardcoded)
AnalyticsLogger.logEvent("screen_view", metadata: {
  "screen": "CertificateScreen",
  "user_tier": "premium"
});
