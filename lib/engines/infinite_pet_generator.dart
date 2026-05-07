import 'package:dart_openai/dart_openai.dart';
import '../config/secrets.dart';

class InfinitePetGenerator {
  static Future<String?> hatchEgg(String userPrompt) async {
    try {
      OpenAI.apiKey = Secrets.openAI;
      final image = await OpenAI.instance.image.create(
        prompt: "A cute, 3D isometric video game mascot character of $userPrompt. Clean transparent background, digital art style, glowing.",
        model: "dall-e-3",
        size: OpenAIImageSize.size1024,
      );
      return image.data.first.url; // Returns the URL of the new custom pet
    } catch (e) {
      return null;
    }
  }
}