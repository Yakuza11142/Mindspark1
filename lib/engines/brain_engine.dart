import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class BrainEngine {
  late GenerativeModel _gemini;

  BrainEngine() {
    OpenAI.apiKey = Secrets.openAI;
    _gemini = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
  }

  Future<String> generateLesson(String topic, bool isPro, bool isPidgin) async {
    String prompt = isPidgin ? "Explain '$topic' in Nigerian Pidgin English." : "Explain '$topic'.";
    if (isPro) {
      try {
        final chat = await OpenAI.instance.chat.create(
          model: "gpt-4-turbo",
          messages: [
            OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.system, content: "You are an expert."),
            OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.user, content: prompt),
          ],
        );
        return chat.choices.first.message.content!.map((e) => e.text).join();
      } catch (e) { return _useGemini(prompt); }
    } else {
      return _useGemini(prompt);
    }
  }

  Future<String> _useGemini(String prompt) async {
    try {
      final res = await _gemini.generateContent([Content.text(prompt)]);
      return res.text ?? "Error.";
    } catch (e) { return "Connection Error."; }
  }
}