import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageCleaner {
  static Future<void> freeUpSpace() async {
    final dir = await getTemporaryDirectory();
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
      print("Cache Cleared");
    }
  }
}