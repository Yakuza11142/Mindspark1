import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../config/secrets_fusion.dart';

class GroqApiService {
  /// Submits a request to the Groq Chat Completions endpoint with a specific model configuration securely
  static Future<String> askGroq(String prompt, String model) async {
    final String cleanedPrompt = prompt.trim();
    final String standardizedModel = model.trim();
    
    developer.log("🧠 Groq API Service: Executing model payload request using: $standardizedModel");

    if (cleanedPrompt.isEmpty) {
      return "Prompt is empty.";
    }

    try {
      final Uri url = Uri.parse("https://api.groq.com/openai/v1/chat/completions");

      final Map<String, String> headers = {
        "Authorization": "Bearer ${SecretsFusion.groqKey}",
        "Content-Type": "application/json"
      };

      final String payloadBody = jsonEncode({
        "model": standardizedModel,
        "messages": [
          {"role": "user", "content": cleanedPrompt}
        ]
      });

      // Defensive 12-second timeout guard prevents network hangs on weak signals [INDEX]
      final http.Response res = await http.post(
        url,
        headers: headers,
        body: payloadBody,
      ).timeout(
        const Duration(seconds: 12),
      );

      // Securely check response status metrics before executing unpacking code blocks [INDEX]
      if (res.statusCode == 200) {
        final dynamic decodedPayload = jsonDecode(res.body);
        
        // Hardened the collection tracking tree using safe explicit conversion initializers [INDEX]
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
        developer.log("⚠️ Groq API Service: Server rejected payload with status code: ${res.statusCode}. Body: ${res.body}");
        return "Groq API timeout.";
      }
    } catch (e, stackTrace) {
      // Descriptive diagnostic tracking telemetry hooks replace loose print operations [INDEX]
      developer.log("❌ Groq API Service: Text retrieval pipeline encountered an operation failure", error: e, stackTrace: stackTrace);
      return "Groq API timeout.";
    }
  }
}
