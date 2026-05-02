import 'dart:convert';
import 'dart:io';

class StringCompressor {
  static String compress(String text) => base64Encode(zlib.encode(utf8.encode(text)));
  static String decompress(String compressed) => utf8.decode(zlib.decode(base64Decode(compressed)));
}