import 'package:flutter/widgets.dart';

class MemoryOptimizer {
  static void clearGraphics() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    print("Memory Purged for Performance.");
  }
}