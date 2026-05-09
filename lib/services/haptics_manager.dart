import 'package:flutter/services.dart';

class Haptics {
  static void success() => HapticFeedback.heavyImpact();
  static void click() => HapticFeedback.selectionClick();
  static void error() => HapticFeedback.vibrate();
}