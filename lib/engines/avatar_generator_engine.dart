import 'package:dart_openai/dart_openai.dart';
import '../config/secrets_fusion.dart';

class AvatarGeneratorEngine {
  static Future<String?> generateAvatar(String description) async {
    OpenAI.apiKey = SecretsFusion.openAI;
    try {
      final image = await OpenAI.instance.image.create(
        prompt: "A beautiful, 3D animated profile picture avatar of: $description. Clean solid background. Cute, expressive, Pixar style.",
        model: "dall-e-3",
        size: OpenAIImageSize.size256, // Small size to save money
      );
      return image.data.first.url;
    } catch (e) {
      return null;
    }
  }
}