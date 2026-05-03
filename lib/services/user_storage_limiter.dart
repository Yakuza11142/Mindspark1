import 'dart:io';
import 'package:path_provider/path_provider.dart';

class UserStorageLimiter {
  static Future<void> enforce100MbLimit() async {
    final dir = await getApplicationDocumentsDirectory();
    int size = 0;
    
    if (dir.existsSync()) {
      dir.listSync(recursive: true).forEach((file) {
        if (file is File) size += file.lengthSync();
      });
      
      if (size > 100000000) { // 100MB
        print("Storage > 100MB. Wiping old cache...");
        dir.listSync().forEach((f) => f.deleteSync());
      }
    }
  }
}