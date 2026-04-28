import 'package:flutter/painting.dart';
class ArMemoryOptimizer {
  static void purgeAvatar() {
    imageCache.clearLiveImages();
    print("🧹 AR Avatar cleared from memory.");
  }
}