import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AggressiveCacheCleaner {
  static Future<void> wipeOldData() async {
    final dir = await getTemporaryDirectory();
    dir.deleteSync(recursive: true);
    print("Storage Optimized.");
  }
}