import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/secrets_fusion.dart';
import 'millisecond_updater.dart';

class GroqService {
  static Future<String> ask(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.groq.com/openai/v1/chat/completions"),
        headers: {"Authorization": "Bearer ${SecretsFusion.groqKey}", "Content-Type": "application/json"},
        body: jsonEncode({
          "model": MillisecondUpdater.groqModel,
          "messages": [{"role": "user", "content": prompt}]
        })
      );
      return jsonDecode(res.body)['choices'][0]['message']['content'];
    } catch (e) { return "Groq offline."; }
  }
}