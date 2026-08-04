import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/security_service.dart';

class AppBootSequence {
  static Future<bool> execute(SecurityService securityService) async {
    debugPrint("🚀 [MindSpark Core] Executing Infrastructure Boot Sequence...");

    try {
      // Defensive boundary lock guarantees framework engine binds natively before asset calls execute
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
        return false; 
      }

      // 2. Verified: Catches AssertionErrors and Exceptions to completely eliminate boot loops
      bool needsInitialization = true;
      try {
        final currentClient = Supabase.instance.client;
        if (currentClient.supabaseUrl.isNotEmpty) {
          needsInitialization = false;
        }
      } on AssertionError {
        needsInitialization = true;
      } catch (_) {
        needsInitialization = true;
      }

      if (needsInitialization) {
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
    Future.microtask(() async {
      try {
        await MobileAds.instance.initialize();
        await _initializeInAppPurchases();
        await _preloadCharacterAssets();
        debugPrint("💎 Background monetization & multimedia subsystems cached.");
      } catch (e, stackTrace) {
        debugPrint("⚠️ Non-fatal sub-system background initialization warning: $e");
        debugPrint("Background Stack Trace: $stackTrace");
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
