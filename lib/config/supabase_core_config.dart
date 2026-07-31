import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCoreConfig {
  // Draws from --dart-define or environment variables cleanly
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  // Track the configuration state internally to prevent duplicate initialization crashes
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) {
      debugPrint("ℹ️ Supabase core services are already active. Skipping initialization loop.");
      return;
    }

    // FIXED: Swapped silent failure print loops for explicit state assertions.
    // This allows your main AppBootSequence launcher to catch missing configuration keys safely.
    if (url.isEmpty || anonKey.isEmpty) {
      throw ArgumentError(
        "❌ FATAL: Supabase configuration credentials are missing from your build environment. "
        "Verify your compile-time --dart-define parameters or secrets.json config mapping lines."
      );
    }

    try {
      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce, // Enforces secure hardware authentication loops
        ),
        realtimeClientOptions: const RealtimeClientOptions(
          eventsPerSecond: 15, // Slightly optimized handling for high-frequency WebRTC signaling packages
        ),
      );
      
      _isInitialized = true;
      debugPrint("☁️ SYSTEM BASELINE: SUPABASE PRODUCTION CLOUD CONNECTED.");
    } catch (e) {
      // Catch exceptions where Supabase might have been initialized outside this class context
      if (e.toString().contains('has already been initialized')) {
        _isInitialized = true;
        return;
      }
      rethrow;
    }
  }

  // FIXED: Added a state assertion rule to the getter to provide explicit troubleshooting tracing logs
  static SupabaseClient get client {
    if (!_isInitialized) {
      throw StateError("❌ SupabaseCoreConfig client accessed before initialize() execution loop passed.");
    }
    return Supabase.instance.client;
  }
}
