import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressor {
  static Future<File?> compress(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final outPath = "${filePath.substring(0, lastIndex)}_out.jpg";
    
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, outPath,
      quality: 50,
    );
    return result != null ? File(result.path) : null;
  }
}