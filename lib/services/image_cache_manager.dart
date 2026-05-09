import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager {
  static void clearCache() {
    DefaultCacheManager().emptyCache();
  }
}