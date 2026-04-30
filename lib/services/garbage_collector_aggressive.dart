import 'package:flutter/painting.dart';

class GarbageCollectorAggressive {
  static void purgeMemory() {
    imageCache.clear();
    imageCache.clearLiveImages();
    print("🧹 Aggressive RAM purge executed. System cooled.");
  }
}