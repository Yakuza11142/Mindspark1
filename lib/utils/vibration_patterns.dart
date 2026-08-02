import 'package:flutter/services.dart';

class VibrationPatterns {
  /// Fires your custom dual-pulse success pattern with full platform-channel safety
  static Future<void> success() async {
    try {
      // 1. First heavy haptic confirmation pulse
      await HapticFeedback.heavyImpact();
      
      // 2. Safe delay allows the physical phone motor to reset its frequency cleanly
      await Future.delayed(const Duration(milliseconds: 100));
      
      // 3. Second light haptic tail pulse creates a premium, high-end feel
      await HapticFeedback.lightImpact();
    } catch (e) {
      // Graceful fallback instantly falls back to standard system vibration if hardware channels are busy
      await HapticFeedback.vibrate();
    }
  }
}
