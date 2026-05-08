import 'package:flutter/services.dart';

class HapticManager {
  static void tap() => HapticFeedback.selectionClick();
  static void success() => HapticFeedback.mediumImpact();
  static void error() => HapticFeedback.heavyImpact();
}