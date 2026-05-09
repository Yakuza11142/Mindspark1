import 'package:flutter/services.dart';

class VibrationEngine {
  static void success() => HapticFeedback.heavyImpact();
  static void light() => HapticFeedback.lightImpact();
  static void error() async {
    await HapticFeedback.heavyImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.heavyImpact();
  }
}