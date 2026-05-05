import 'package:dart_openai/dart_openai.dart';
import '../config/secrets_fusion.dart';

class DalleImageEngine {
  static Future<String?> generate(String topic) async {
    OpenAI.apiKey = SecretsFusion.openAI;
    try {
      final image = await OpenAI.instance.image.create(
        prompt: "A hyper-realistic 8K image of $topic, cinematic lighting.",
        model: "dall-e-3", size: OpenAIImageSize.size1024,
      );
      return image.data.first.url;
    } catch (e) { return null; }
  }
}