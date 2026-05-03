import 'package:flutter/services.dart';

class HapticFeedbackPro {
  static void click() => HapticFeedback.selectionClick();
  static void success() => HapticFeedback.mediumImpact();
}