import 'package:flutter/services.dart';
import 'dart:async';

class HapticBreathGuide {
  static void initiateCalmBreathing() async {
    print("🌬️ Initiating Haptic Breathing Guide...");
    for (int i = 0; i < 4; i++) {
      HapticFeedback.lightImpact(); // Breathe in
      await Future.delayed(const Duration(seconds: 1));
    }
    await Future.delayed(const Duration(seconds: 4)); // Hold
    for (int i = 0; i < 4; i++) {
      HapticFeedback.mediumImpact(); // Breathe out
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}