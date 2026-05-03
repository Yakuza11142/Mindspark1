import 'package:flutter/painting.dart';

class VideoMemoryManager {
  static void purgeRam() {
    imageCache.clearLiveImages();
    print("RAM Purged during video stream to prevent crashes.");
  }
}