import 'package:flutter/painting.dart';

class GarbageCollectionForcer {
  static void purge() {
    imageCache.clear();
    imageCache.clearLiveImages();
    print("🗑️ Aggressive RAM Purge Executed.");
  }
}