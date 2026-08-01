import 'package:flutter/widgets.dart'; 
import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:groq_sdk/groq_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import '../services/ai_version_controller.dart';

class SparkAiCore {
  static Future<String> generateResponse(
      String userPrompt, bool isPaidUser) async {
    const String systemInstruction = "You are Spark AI, a global educational genius. "
        "Detect the user's language and respond perfectly in that language. "
        "No examples, just direct expertise.";

    try {
      await AiVersionController.syncModels();
      return await _processAiRequest(userPrompt, systemInstruction, isPaidUser);
    } catch (e, stackTrace) {
      developer.log("Initialization or sync crash inside SparkAiCore", error: e, stackTrace: stackTrace);
      return "Initialization error. Please try again.";
    }
  }

  static Future<String> _processAiRequest(
      String prompt, String persona, bool isPaid) async {
    return isPaid 
        ? await _useProBrain(prompt, persona) 
        : await _useFreeBrain(prompt, persona);
  }

  // PRO ENGINE (GROQ + OPENAI FALLBACK)
  static Future<String> _useProBrain(String prompt, String persona) async {
    // 1. PRIMARY ENGINE: GROQ COMPLETION
    try {
      final String? apiKey = dotenv.maybeGet('GROQ_API_KEY');
      if (apiKey == null || apiKey.isEmpty) throw Exception("Missing GROQ Key");

      final groq = Groq(apiKey, model: AiVersionController.groqModel);
      final chat = groq.startNewChat(); // Corrected: Model is passed to the parent client, not the chat builder
      final response = await chat.sendMessage("$persona\n\n$prompt"); // Returns a GroqChatMessage
      
      // FIXED: Directly extracts text from Groq's native message structure
      final String textContent = response.text;
      if (textContent.isNotEmpty) return textContent.trim();
    } catch (e, groqStack) {
      developer.log("Groq failure pipeline, engaging OpenAI fallback", error: e, stackTrace: groqStack);
    }

    // 2. FALLBACK ENGINE: OPENAI COMPLETION
    try {
      final String? openAiKey = dotenv.maybeGet('OPENAI_API_KEY');
      if (openAiKey == null || openAiKey.isEmpty) throw Exception("Missing OpenAI Key");

      OpenAI.apiKey = openAiKey;
      
      // FIXED: Uses stable, version-agnostic Map initialization to completely bypass constructor changes
      final chat = await OpenAI.instance.chat.create(
        model: AiVersionController.openAiModel,
        messages: [
          OpenAIChatCompletionChoiceMessageModel.fromMap({
            "role": "system",
            "content": persona,
          }),
          OpenAIChatCompletionChoiceMessageModel.fromMap({
            "role": "user",
            "content": prompt,
          }),
        ],
      );
      
      final dynamic rawContent = chat.choices.first.message.content;
      if (rawContent != null) {
        return rawContent.toString().trim();
      }
      return "No response content received.";
    } catch (err, openAiStack) {
      developer.log("OpenAI fallback failure pipeline terminated", error: err, stackTrace: openAiStack);
      return "Pro Brain Link unstable.";
    }
  }

  // FREE ENGINE (GEMINI)
  static Future<String> _useFreeBrain(String prompt, String persona) async {
    try {
      final String? geminiKey = dotenv.maybeGet('GEMINI_API_KEY');
      if (geminiKey == null || geminiKey.isEmpty) throw Exception("Missing Gemini Key");

      // FIXED: Uses official constructor utilities to ensure strict model compliance
      final model = GenerativeModel(
        model: AiVersionController.geminiModel,
        apiKey: geminiKey,
        systemInstruction: Content.system(persona),
      );
      
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "Brain recalibrating...";
    } catch (e, geminiStack) {
      developer.log("Gemini infrastructure core failure", error: e, stackTrace: geminiStack);
      return "Network error.";
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env"); 
  } catch (e) {
    developer.log("Environment configuration missing target file .env");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
