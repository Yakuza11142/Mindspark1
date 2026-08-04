import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCoreConfig {
  // Draws from --dart-define or environment variables cleanly
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static Future<void> initialize() async {
    // Directly inspect the underlying Singleton layer.
    // This provides structural idempotency across hot restarts without relying on a reset-prone bool.
    try {
      if (Supabase.instance.client.supabaseUrl.isNotEmpty) {
        debugPrint("ℹ️ Supabase core services are already active. Skipping initialization loop.");
        return;
      }
    } catch (_) {
      // An exception caught here explicitly means the instance is uninitialized and safe to mount.
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
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce, // Enforces secure hardware authentication loops
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        eventsPerSecond: 15, // Slightly optimized handling for high-frequency WebRTC signaling packages
      ),
    );

    debugPrint("☁️ SYSTEM BASELINE: SUPABASE PRODUCTION CLOUD CONNECTED.");
  }

  // State checking queries the actual instance dynamically instead of using a cached local field
  static SupabaseClient get client {
    try {
      return Supabase.instance.client;
    } catch (_) {
      throw StateError("❌ SupabaseCoreConfig client accessed before initialize() execution loop passed.");
    }
  }
}
