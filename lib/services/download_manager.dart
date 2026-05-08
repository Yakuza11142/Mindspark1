import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadManager {
  static Future<String?> downloadAsset(String url, String filename) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = "${dir.path}/$filename";
      await Dio().download(url, path);
      return path;
    } catch (e) {
      return null;
    }
  }
}