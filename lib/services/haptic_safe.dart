import 'package:flutter/services.dart';

class HapticSafe {
  static void tap() async {
    try { await HapticFeedback.lightImpact(); } catch (_) {}
  }
  static void success() async {
    try { await HapticFeedback.heavyImpact(); } catch (_) {}
  }
}