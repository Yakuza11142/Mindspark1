import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:groq_sdk/groq_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/ai_version_controller.dart';

class SparkAiCore {
  static Future<String> generateResponse(String userPrompt, bool isPaidUser) async {
    String systemInstruction = "You are Spark AI, a global educational genius. "
        "Detect the user's language and respond perfectly in that language. "
        "No examples, just direct expertise.";

    // Run cloud sync and AI processing simultaneously
    final results = await Future.wait([
      AiVersionController.syncModels(),
      _processAiRequest(userPrompt, systemInstruction, isPaidUser),
    ]);

    return results[1] as String; // Return the AI response result
  }

  static Future<String> _processAiRequest(String prompt, String persona, bool isPaid) async {
    if (isPaid) {
      return await _useProBrain(prompt, persona);
    } else {
      return await _useFreeBrain(prompt, persona);
    }
  }

  // PRO ENGINE (GROQ + OPENAI FALLBACK)
  static Future<String> _useProBrain(String prompt, String persona) async {
    try {
      // Draw Groq key from .env
      final groq = Groq(dotenv.get('GROQ_API_KEY'));
      final chat = await groq.startChat(model: AiVersionController.groqModel);
      final response = await chat.sendMessage("$persona\n\n$prompt");
      return response.choices.first.message.content;
    } catch (e) {
      try {
        // Draw OpenAI key from .env
        OpenAI.apiKey = dotenv.get('OPENAI_API_KEY');
        final chat = await OpenAI.instance.chat.create(
          model: AiVersionController.openAiModel,
          messages: [
            OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.system, content: persona),
            OpenAIChatCompletionChoiceMessageModel(role: OpenAIChatMessageRole.user, content: prompt),
          ],
        );
        return chat.choices.first.message.content!.map((e) => e.text).join();
      } catch (err) {
        return "Pro Brain Link unstable.";
      }
    }
  }

  // FREE ENGINE (GEMINI)
  static Future<String> _useFreeBrain(String prompt, String persona) async {
    try {
      // Draw Gemini key from .env
      final model = GenerativeModel(
        model: AiVersionController.geminiModel,
        apiKey: dotenv.get('GEMINI_API_KEY'),
      );
      final response = await model.generateContent([Content.text("$persona\n\n$prompt")]);
      return response.text ?? "Brain recalibrating...";
    } catch (e) {
      return "Network error.";
    }
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load the keys
  runApp(const MyApp());
}
