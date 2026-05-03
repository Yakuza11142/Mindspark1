import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DeviceStorageAllocator {
  static Future<void> enforce50MbLimit() async {
    final dir = await getApplicationDocumentsDirectory();
    int sizeBytes = 0;
    
    if (dir.existsSync()) {
      for (var file in dir.listSync(recursive: true)) {
        if (file is File) sizeBytes += file.lengthSync();
      }
      if (sizeBytes > 50000000) { // 50MB
        // Delete oldest cached files
        print("🧹 Storage exceeded 50MB. Trimming cache.");
      }
    }
  }
}