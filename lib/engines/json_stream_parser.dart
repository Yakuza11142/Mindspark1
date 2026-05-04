import 'dart:convert';
import 'package:http/http.dart' as http;

class JsonStreamParser {
  static Stream<String> streamGroqResponse(String prompt, String apiKey) async* {
    final request = http.Request("POST", Uri.parse("https://api.groq.com/openai/v1/chat/completions"))
      ..headers.addAll({"Authorization": "Bearer $apiKey", "Content-Type": "application/json"})
      ..body = jsonEncode({"model": "llama3-8b-8192", "messages":[{"role": "user", "content": prompt}], "stream": true});

    final response = await request.send();
    
    await for (var chunk in response.stream.transform(utf8.decoder).transform(const LineSplitter())) {
      if (chunk.startsWith("data: ") && chunk != "data: [DONE]") {
        try {
          final data = jsonDecode(chunk.substring(6));
          final content = data['choices'][0]['delta']['content'];
          if (content != null) yield content; // Yields text token-by-token
        } catch (e) {
          continue; // Ignore broken chunks
        }
      }
    }
  }
}