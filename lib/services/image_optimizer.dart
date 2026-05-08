import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart'; // Add to pubspec

class ImageOptimizer {
  static Future<File?> compress(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, 
      outPath,
      quality: 70, // 30% reduction in size
    );
    
    return result != null ? File(result.path) : null;
  }
}