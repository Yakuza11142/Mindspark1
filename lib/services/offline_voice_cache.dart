import 'dart:io';
import 'package:path_provider/path_provider.dart';

class OfflineVoiceCache {
  static Future<File?> getCachedFile(String textId) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/tts_$textId.mp3');
    if (await file.exists()) return file;
    return null;
  }
}