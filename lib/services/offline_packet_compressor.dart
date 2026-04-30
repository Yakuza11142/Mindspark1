import 'dart:convert';
import 'dart:io';

class OfflinePacketCompressor {
  static String zipPayload(Map<String, dynamic> data) {
    List<int> bytes = utf8.encode(jsonEncode(data));
    List<int> compressed = zlib.encode(bytes);
    return base64Encode(compressed);
  }
}