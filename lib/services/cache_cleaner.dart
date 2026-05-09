import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CacheCleaner {
  static Future<void> cleanOldFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync();
    // Delete files older than 7 days
    for (var f in files) {
      if (f is File) {
        DateTime created = await f.lastModified();
        if (DateTime.now().difference(created).inDays > 7) {
          await f.delete();
        }
      }
    }
  }
}