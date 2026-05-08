import 'package:flutter/foundation.dart';

class MemoryLeakTracker {
  static void checkImageCache() {
    if (kDebugMode) {
      final int count = PaintingBinding.instance.imageCache.currentSize;
      print("MEMORY CHECK: $count images in cache.");
      if (count > 100) {
        print("WARNING: High Memory Usage. Clearing Cache.");
        PaintingBinding.instance.imageCache.clear();
      }
    }
  }
}