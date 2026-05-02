import 'package:flutter/material.dart';

class AgeAdaptedFontScaler {
  static double getFontSize(int age) {
    if (age > 40) return 20.0; // Larger text for older adult learners
    return 16.0; // Standard size for teens
  }
}