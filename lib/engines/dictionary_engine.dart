import 'dart:convert';
import 'package:http/http.dart' as http;

class DictionaryEngine {
  static Future<String> define(String word) async {
    try {
      final res = await http.get(Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        return data[0]['meanings'][0]['definitions'][0]['definition'];
      }
    } catch (e) {}
    return "Definition not found.";
  }
}