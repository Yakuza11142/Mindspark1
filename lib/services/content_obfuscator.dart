import 'dart:convert';

class ContentObfuscator {
  static String hide(String text) => base64Encode(utf8.encode(text));
  static String reveal(String hidden) => utf8.decode(base64Decode(hidden));
}