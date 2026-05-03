import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCoreConfig {
  // Draws from --dart-define or environment variables
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static Future<void> initialize() async {
    if (url.isEmpty || anonKey.isEmpty) {
      print("❌ ERROR: Supabase Keys are missing from environment.");
      return;
    }

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        eventsPerSecond: 10,
      ),
    );
    print("☁️ SUPABASE CLOUD CONNECTED.");
  }

  static SupabaseClient get client => Supabase.instance.client;
}
