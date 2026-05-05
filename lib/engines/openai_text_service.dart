import 'package:dart_openai/dart_openai.dart';
import '../config/secrets_fusion.dart';

class OpenAiTextService {
  static Future<String> ask(String prompt) async {
    OpenAI.apiKey = SecretsFusion.openAI;
    try {
      final chat = await OpenAI.instance.chat.create(
        model: "gpt-4-turbo",
        messages:[OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.user, content: prompt)],
      );
      return chat.choices.first.message.content!.map((e) => e.text).join();
    } catch (e) { return "OpenAI timeout."; }
  }
}