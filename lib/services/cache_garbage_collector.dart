import 'package:flutter/painting.dart';

class GarbageCollector {
  static void run() {
    imageCache.clear();
    imageCache.clearLiveImages();
  }
}