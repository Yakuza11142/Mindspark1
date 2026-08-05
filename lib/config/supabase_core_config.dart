import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCoreConfig {
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static Future<void> initialize() async {
    // 🚀 FIXED: Removed all calls to Supabase.instance when checking initialization status.
    // In supabase_flutter, checking Supabase.instance before initialization throws an internal 
    // AssertionError which is not designed to be captured for operational conditional branching.
    // Checking the uninitialized static flag condition natively via standard try/catch blocks 
    // instead ensures flawless cross-platform compilations and hot restarts with no runtime crashes.
    try {
      final bool checkActive = Supabase.hasInstance;
      if (checkActive) {
        debugPrint("ℹ️ Supabase core services are already active. Skipping initialization loop.");
        return;
      }
    } catch (_) {
      // Static instance exception catch framework guard block
    }

    if (url.isEmpty || anonKey.isEmpty) {
      throw ArgumentError(
        "❌ FATAL: Supabase configuration credentials are missing from your build environment. "
        "Verify your compile-time --dart-define parameters or secrets.json config mapping lines."
      );
    }

    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      authOptions: const AuthClientOptions(
        flowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        eventsPerSecond: 15,
      ),
    );

    debugPrint("☁️ SYSTEM BASELINE: SUPABASE PRODUCTION CLOUD CONNECTED.");
  }

  static SupabaseClient get client {
    try {
      return Supabase.instance.client;
    } catch (_) {
      throw StateError("❌ SupabaseCoreConfig client accessed before initialize() execution loop passed.");
    }
  }
}
