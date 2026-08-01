import 'package:dart_openai/dart_openai.dart';
import 'dart:developer' as developer;
import '../config/secrets_fusion.dart';

class DalleImageEngine {
  // Consolidated package initialization scope early to protect against global variable race conditions [INDEX]
  static bool _isConfigured = false;

  static void _ensureInitialized() {
    if (!_isConfigured) {
      OpenAI.apiKey = SecretsFusion.openAI;
      _isConfigured = true;
    }
  }

  /// Generates a unique hyper-realistic image link safely using OpenAI DALL-E 3 models [INDEX]
  static Future<String?> generate(String topic) async {
    final String cleanedTopic = topic.trim();
    developer.log("🔮 DalleImageEngine: Requesting asset generation loop for prompt topic: $cleanedTopic");

    if (cleanedTopic.isEmpty) {
      developer.log("⚠️ DalleImageEngine: Blocked execution due to blank user input prompt string.");
      return null;
    }

    _ensureInitialized();

    try {
      final OpenAIImageModel imageContainer = await OpenAI.instance.image.create(
        prompt: "A hyper-realistic 8K image of $cleanedTopic, cinematic lighting.",
        model: "dall-e-3",
        size: OpenAIImageSize.size1024,
      ).timeout(
        const Duration(seconds: 15), // Strict network timeout prevents thread freezes on weak signals [INDEX]
      );

      final String? generatedUrl = imageContainer.data.first.url;
      if (generatedUrl != null && generatedUrl.isNotEmpty) {
        developer.log("✅ DalleImageEngine: Successfully generated image asset URL target.");
        return generatedUrl.trim();
      }

      throw Exception("Upstream OpenAI image model array container returned unpopulated.");
    } catch (e, stackTrace) {
      // Attached robust diagnostic logging telemetry hooks to capture network faults and moderation flags safely [INDEX]
      developer.log("❌ DalleImageEngine: Generation pipeline encountered an operational exception", error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
