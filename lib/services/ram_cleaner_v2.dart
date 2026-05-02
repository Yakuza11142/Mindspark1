import 'package:flutter/painting.dart';

class RamCleanerV2 {
  static void purgeExcessMemory() {
    if (PaintingBinding.instance.imageCache.currentSizeBytes > 20000000) { // 20MB
      PaintingBinding.instance.imageCache.clear();
      print("🧹 Cleared 20MB of Image RAM.");
    }
  }
}