import 'package:flutter/widgets.dart';

class DynamicFontResizer {
  static double getFontSize(BuildContext context, double baseSize) {
    double width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.85; // Scale down for tiny screens
    return baseSize;
  }
}