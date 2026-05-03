import 'dart:convert';
class FastJsonDecoder {
  static Map<String, dynamic> decode(String raw) => jsonDecode(raw);
}