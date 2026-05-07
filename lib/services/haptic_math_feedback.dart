import 'package:flutter/services.dart';

class HapticMathFeedback {
  static void onLineDrawn() => HapticFeedback.selectionClick();
  static void onEquationSolved() => HapticFeedback.heavyImpact();
}