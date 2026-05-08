import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageCleanupJob {
  static Future<void> run() async {
    final dir = await getTemporaryDirectory();
    if (dir.existsSync()) dir.deleteSync(recursive: true);
  }
}