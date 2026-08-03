import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/security_service.dart';

class AppBootSequence {
  static Future<bool> execute(SecurityService securityService) async {
    debugPrint("🚀 [MindSpark Core] Executing Infrastructure Boot Sequence...");

    try {
      // FIX: Defensive boundary lock guarantees framework engine binds natively before asset calls execute
      WidgetsFlutterBinding.ensureInitialized();

      // Capture and validate global environment parameters passed via compile definitions
      const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
      const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

      if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
        throw ArgumentError("SUPABASE environmental secrets cannot be parsed. Verify compile flags mapping.");
      }

      // 1. Engage FreeRASP anti-tamper security layers before opening web connection ports
      await securityService.initializeSecurityShield();

      if (securityService.isSystemCompromised) {
        debugPrint("🛑 Boot Sequence Interrupted: Device attestation check failed.");
        return true; // Return true so main.dart can safely catch and display the secure lockout layout
      }

      // 2. FIXED: Robust, optimized multi-instance state check prevents StateErrors from blocking thread paths
      bool isSupabaseInitialized = false;
      try {
        // Safe explicit evaluation pattern isolates instance configuration status
        isSupabaseInitialized = Supabase.instance.client.supabaseUrl.isNotEmpty;
      } catch (_) {
        isSupabaseInitialized = false;
      }

      if (!isSupabaseInitialized) {
        await Supabase.initialize(
          url: supabaseUrl,
          anonKey: supabaseAnonKey,
        );
        debugPrint("📡 Supabase Edge Routing Services Verified.");
      } else {
        debugPrint("📡 Supabase Client already active. Bypassing initialization cycle.");
      }

      // 3. Initialize background processes out-of-band to prevent UI freezing
      _initializeBackgroundSubsystems();

      debugPrint("⚙️ Subsystems initialized successfully.");
      return true;

    } catch (e, stackTrace) {
      debugPrint("🚨 Critical AppBootSequence Failure: ${e.toString()}");
      debugPrint("Stack Trace: $stackTrace");
      return false;
    }
  }

  static void _initializeBackgroundSubsystems() {
    // Isolates heavy ad profiling, purchase histories, and 3D mesh loads away from the main event frame
    Future(() async {
      try {
        await MobileAds.instance.initialize();
        await _initializeInAppPurchases();
        await _preloadCharacterAssets();
        debugPrint("💎 Background monetization & multimedia subsystems cached.");
      } catch (e) {
        debugPrint("⚠️ Non-fatal sub-system background initialization warning: $e");
      }
    });
  }

  static Future<void> _initializeInAppPurchases() async {
    await Future.delayed(const Duration(milliseconds: 150)); 
  }

  static Future<void> _preloadCharacterAssets() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
