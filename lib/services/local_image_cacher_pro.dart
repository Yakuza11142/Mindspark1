// Requires path_provider
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class LocalImageCacherPro {
  static Future<void> saveToDisk(String imageUrl, String filename) async {
    try {
      final res = await http.get(Uri.parse(imageUrl));
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename.jpg');
      await file.writeAsBytes(res.bodyBytes);
    } catch (e) {
      print("Image cache failed.");
    }
  }
}