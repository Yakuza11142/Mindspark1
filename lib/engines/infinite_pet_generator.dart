import 'package:dart_openai/dart_openai.dart';
import 'dart:developer' as developer;
import '../config/secrets.dart';

class InfinitePetGenerator {
  // Consolidated package initialization scope early to protect against global variable race conditions
  static bool _isConfigured = false;

  static void _ensureInitialized() {
    if (!_isConfigured) {
      OpenAI.apiKey = Secrets.openAI;
      _isConfigured = true;
    }
  }

  /// Generates a unique 3D mascot pet image link safely using OpenAI DALL-E 3 models
  static Future<String?> hatchEgg(String userPrompt) async {
    final String cleanedPrompt = userPrompt.trim();
    developer.log("🔮 InfinitePetGenerator: Initiating mascot generation loop for prompt: $cleanedPrompt");

    if (cleanedPrompt.isEmpty) {
      developer.log("⚠️ InfinitePetGenerator: Blocked execution due to blank user input prompt string.");
      return null;
    }

    _ensureInitialized();

    try {
      final OpenAIImageModel imageContainer = await OpenAI.instance.image.create(
        // FIXED: Corrected the variable string interpolation reference identifier to match the declared variable name
        prompt: "A cute, 3D isometric video game mascot character of $cleanedPrompt. Clean transparent background, digital art style, glowing.",
        model: "dall-e-3",
        size: OpenAIImageSize.size1024,
      ).timeout(
        const Duration(seconds: 15), 
      );

      final String? generatedUrl = imageContainer.data.first.url;
      if (generatedUrl != null && generatedUrl.isNotEmpty) {
        developer.log("✅ InfinitePetGenerator: Successfully generated pet asset URL target.");
        return generatedUrl.trim();
      }

      throw Exception("Upstream OpenAI image model array container returned unpopulated.");
    } catch (e, stackTrace) {
      developer.log("❌ InfinitePetGenerator: Generation pipeline encountered an operational exception", error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
