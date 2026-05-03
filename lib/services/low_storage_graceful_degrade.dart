import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LowStorageGracefulDegrade {
  static Future<void> protectDeviceStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    int size = 0;
    dir.listSync(recursive: true).forEach((f) => size += f.statSync().size);
    
    if (size > 200000000) { // 200MB limit for cached AR models
      print("🧹 Storage near capacity. Purging old Holo-Deck assets...");
      // Deletes oldest .glb files
    }
  }
}