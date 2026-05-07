import 'package:flutter/gestures.dart';

class StylusDetector {
  static bool isStylus(PointerDeviceKind kind) {
    return kind == PointerDeviceKind.stylus || kind == PointerDeviceKind.invertedStylus;
  }
}