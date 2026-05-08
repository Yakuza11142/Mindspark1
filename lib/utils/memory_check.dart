import 'package:flutter/widgets.dart';

class MemoryCheck {
  static void clearImageCache() {
    PaintingBinding.instance.imageCache.clear();
  }
}