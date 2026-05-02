import 'dart:convert';
import 'dart:io';

class JsonPayloadCompressor {
  static String compressToZlibBase64(Map<String, dynamic> data) {
    List<int> stringBytes = utf8.encode(jsonEncode(data));
    List<int> gzippedBytes = zlib.encode(stringBytes); // Zlib is highly efficient
    return base64Encode(gzippedBytes);
  }
}