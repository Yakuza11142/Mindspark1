import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class CbtOfflineImageCacher {
  static Future<void> preloadExamImages(BuildContext context, List<String> imageUrls) async {
    for (String url in imageUrls) {
      await precacheImage(NetworkImage(url), context);
    }
    print("🖼️ All CBT Biology Diagrams Cached Offline.");
  }
}