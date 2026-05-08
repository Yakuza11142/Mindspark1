import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheCleanupService {
  static Future<void> clean() async {
    final dir = await getTemporaryDirectory();
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
  }
}