import 'package:flutter/painting.dart';

class ImageMemoryCacheLimiter {
  static void setLimits() {
    // Limits the app to only hold 50 images in RAM at a time. Drops old ones automatically.
    PaintingBinding.instance.imageCache.maximumSize = 50; 
    PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20; // 50 MB
  }
}