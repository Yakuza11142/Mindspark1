import 'package:flutter/services.dart';

class HapticFeedbackManager {
  static void lightTap() => HapticFeedback.lightImpact();
  static void success() => HapticFeedback.mediumImpact();
  static void error() => HapticFeedback.heavyImpact();
}