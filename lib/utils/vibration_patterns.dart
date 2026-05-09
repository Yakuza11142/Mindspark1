import 'package:flutter/services.dart';

class VibrationPatterns {
  static Future<void> success() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }
}