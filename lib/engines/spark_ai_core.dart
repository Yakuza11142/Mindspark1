import 'package:flutter/widgets.dart'; // Added for WidgetsFlutterBinding & runApp
import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:groq_sdk/groq_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../services/ai_version_controller.dart';

class SparkAiCore {
  static Future<String> generateResponse(
      String userPrompt, bool isPaidUser) async {
    String systemInstruction = "You are Spark AI, a global educational genius. "
        "Detect the user's language and respond perfectly in that language. "
        "No examples, just direct expertise.";

    final results = await Future.wait([
      AiVersionController.syncModels(),
      _processAiRequest(userPrompt, systemInstruction, isPaidUser),
    ]);

    return results[1] as String;
  }

  static Future<String> _processAiRequest(
      String prompt, String persona, bool isPaid) async {
    if (isPaid) {
      return await _useProBrain(prompt, persona);
    } else {
      return await _useFreeBrain(prompt, persona);
    }
  }

  // PRO ENGINE (GROQ + OPENAI FALLBACK)
  static Future<String> _useProBrain(String prompt, String persona) async {
    try {
      final groq = Groq(dotenv.get('GROQ_API_KEY'));
      
      // Fixed: Restored the CI-deleted chat initialization line
      final chat = groq.startNewChat(model: AiVersionController.groqModel); 
      final response = await chat.sendMessage("$persona\n\n$prompt");
      return response.choices.first.message.content;
    } catch (e) {
      try {
        OpenAI.apiKey = dotenv.get('OPENAI_API_KEY');
        final chat = await OpenAI.instance.chat.create(
          model: AiVersionController.openAiModel,
          messages: [
            OpenAIChatCompletionChoiceMessageModel(
                role: OpenAIChatMessageRole.system, content: persona),
            OpenAIChatCompletionChoiceMessageModel(
                role: OpenAIChatMessageRole.user, content: prompt),
          ],
        );
        
        // Fixed: Extracted text directly without the illegal map function
        return chat.choices.first.message.content?.first.text ?? "No response.";
      } catch (err) {
        return "Pro Brain Link unstable.";
      }
    }
  }

  // FREE ENGINE (GEMINI)
  static Future<String> _useFreeBrain(String prompt, String persona) async {
    try {
      final model = GenerativeModel(
        model: AiVersionController.geminiModel,
        apiKey: dotenv.get('GEMINI_API_KEY'),
      );
      final response =
          await model.generateContent([Content.text("$persona\n\n$prompt")]);
      return response.text ?? "Brain recalibrating...";
    } catch (e) {
      return "Network error.";
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); 
  // Make sure MyApp() is defined somewhere in your project scope
  runApp(const MyApp()); 
}

// Dummy placeholder to prevent compiler warnings in this file context
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
