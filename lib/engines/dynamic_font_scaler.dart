import 'package:flutter/widgets.dart';

class LayoutSettings {
  // The screen width your design was originally based on (standard mobile)
  static double designWidth = 375.0; 
  
  // Optional: Global multiplier to allow users to increase text size manually
  static double userScaleFactor = 1.0; 
}

class DynamicFontScaler {
  static double scale(BuildContext context, double baseSize) {
    // 1. Get the physical screen dimensions
    final Size size = MediaQuery.of(context).size;
    final double shortSide = size.width < size.height ? size.width : size.height;

    // 2. Calculate the ratio between current device and design standard
    double scaleFactor = shortSide / LayoutSettings.designWidth;

    // 3. Prevent text from getting TOO small or TOO large (Clamping)
    // Scale ranges from 0.8x to 2.5x of the base size
    double finalScale = scaleFactor.clamp(0.8, 2.5);

    return baseSize * finalScale * LayoutSettings.userScaleFactor;
  }
}
