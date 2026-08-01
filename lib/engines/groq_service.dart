import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../config/secrets_fusion.dart';
import 'millisecond_updater.dart';

class GroqService {
  /// Sends a text prompt to the Groq API endpoint and returns a clean string payload response safely
  static Future<String> ask(String prompt) async {
    final String cleanedPrompt = prompt.trim();
    developer.log("🧠 GroqService: Submitting execution request to text generation pipeline.");

    if (cleanedPrompt.isEmpty) {
      return "Prompt is empty.";
    }

    try {
      // Standardize the outbound HTTP POST connection routing endpoint path
      final Uri url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");

      final Map<String, String> headers = {
        // Safely integrated authorization property parameters back into your network headers map
        "Authorization": "Bearer ${SecretsFusion.groqKey}",
        "Content-Type": "application/json"
      };

      final String payloadBody = jsonEncode({
        "model": MillisecondUpdater.groqModel,
        "messages": [
          {"role": "user", "content": cleanedPrompt}
        ]
      });

      // Attached a defensive 10-second timeout guard to prevent connection freezes on spotty signals
      final http.Response res = await http.post(
        url,
        headers: headers,
        body: payloadBody,
      ).timeout(
        const Duration(seconds: 10),
      );

      if (res.statusCode == 200) {
        final dynamic decodedPayload = jsonDecode(res.body);
        
        // Hardened the deserialization tracking tree using safe explicit collection initialization constructors
        if (decodedPayload is Map) {
          final Map<String, dynamic> structuredJson = Map<String, dynamic>.from(decodedPayload);
          final List<dynamic>? choices = structuredJson['choices'] as List<dynamic>?;
          
          if (choices != null && choices.isNotEmpty) {
            final dynamic firstChoice = choices.first;
            if (firstChoice is Map && firstChoice['message'] != null) {
              final Map<String, dynamic> messageMap = Map<String, dynamic>.from(firstChoice['message'] as Map);
              final String? content = messageMap['content'] as String?;
              if (content != null) {
                return content.trim();
              }
            }
          }
        }
        throw FormatException("Server returned an invalid or un-parsable JSON choice array layout container.");
      } else {
        developer.log("⚠️ GroqService: Server rejected payload with status code: ${res.statusCode}. Body: ${res.body}");
        return "Groq offline.";
      }
    } catch (e, stackTrace) {
      // Attached robust logging telemetry hooks to capture network dropouts and parsing errors safely
      developer.log("❌ GroqService: Processing pipeline encountered an unexpected exception", error: e, stackTrace: stackTrace);
      return "Groq offline.";
    }
  }
}
