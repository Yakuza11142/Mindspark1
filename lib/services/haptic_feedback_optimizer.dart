import 'package:flutter/services.dart';

class HapticFeedbackOptimizer {
  static bool isZenMode = false;
  static void vibrate() {
    if (!isZenMode) HapticFeedback.lightImpact();
  }
}