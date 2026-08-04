import 'package:dart_openai/dart_openai.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:groq_sdk/groq_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;
import '../services/ai_version_controller.dart';

class SparkAiCore {
  static Future<String> generateResponse(
      String userPrompt, bool isPaidUser) async {
    const String systemInstruction = "You are Spark, a global educational genius. "
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
      final chat = groq.startNewChat(); 
      final response = await chat.sendMessage("$persona\n\n$prompt"); 

      // FIXED: Safely extract response text by diving into the choices container array hierarchy
      final String? textContent = response.choices.first.message.content;
      if (textContent != null && textContent.isNotEmpty) return textContent.trim();
    } catch (e, groqStack) {
      developer.log("Groq failure pipeline, engaging OpenAI fallback", error: e, stackTrace: groqStack);
    }

    // 2. FALLBACK ENGINE: OPENAI COMPLETION
    try {
      final String? openAiKey = dotenv.maybeGet('OPENAI_API_KEY');
      if (openAiKey == null || openAiKey.isEmpty) throw Exception("Missing OpenAI Key");

      OpenAI.apiKey = openAiKey;

      // FIXED: Used canonical, type-safe API constructors replacing broken .fromMap calls
      final chat = await OpenAI.instance.chat.create(
        model: AiVersionController.openAiModel,
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.system,
            content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(persona)],
          ),
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(prompt)],
          ),
        ],
      );

      final String? rawContent = chat.choices.first.message.content?.first.text;
      if (rawContent != null) {
        return rawContent.trim();
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

      // FIXED: Bound configuration block safely using valid content wrappers matching Google SDK changes
      final model = GenerativeModel(
        model: AiVersionController.geminiModel,
        apiKey: geminiKey,
        config: GenerateContentConfig(
          systemInstruction: Content.system(persona),
        ),
      );

      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "Brain recalibrating...";
    } catch (e, geminiStack) {
      developer.log("Gemini infrastructure core failure", error: e, stackTrace: geminiStack);
      return "Network error.";
    }
  }
}
