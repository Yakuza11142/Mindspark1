import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'file_encryption_service.dart';

class SecureFileManager {
  static Future<void> saveSecureLesson(String filename, String content) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename.spark'); // Custom extension
    await file.writeAsString(content);
    await FileEncryptionService.encryptFile(file);
  }
}