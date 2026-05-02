import 'dart:convert';

class PayloadScrambler {
  static String scramble(Map<String, dynamic> data) {
    String jsonStr = jsonEncode(data);
    List<int> bytes = utf8.encode(jsonStr);
    List<int> scrambled = bytes.map((b) => b ^ 0x7A).toList(); // Fast XOR cipher
    return base64Encode(scrambled);
  }
}