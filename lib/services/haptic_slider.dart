import 'package:flutter/services.dart';

class HapticSlider {
  static void onSlideChange(double value) {
    if (value % 10 == 0) {
      HapticFeedback.selectionClick(); // Clicks on whole numbers
    }
  }
}