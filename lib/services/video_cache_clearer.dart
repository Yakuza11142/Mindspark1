import 'dart:io';
import 'package:path_provider/path_provider.dart';

class VideoCacheClearer {
  static Future<void> wipeOldVideos() async {
    final dir = await getTemporaryDirectory();
    if (dir.existsSync()) {
      dir.listSync().forEach((file) {
        if (file.path.endsWith('.mp4')) file.deleteSync();
      });
    }
  }
}