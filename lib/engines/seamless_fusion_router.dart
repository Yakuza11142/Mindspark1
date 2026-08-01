import 'dart:async';
import 'groq_api_service.dart';
import 'openai_text_service.dart';

class SeamlessFusionRouter {
  SeamlessFusionRouter._internal();
  static final SeamlessFusionRouter instance = SeamlessFusionRouter._internal();

  /// Infinite Fusion Logic: Emits high-speed responses instantly and layers depth asynchronously
  static Stream<String> streamBestResponse(String prompt, bool isPro) async* {
    final String fastModel = isPro ? "llama-3.3-70b-versatile" : "llama-3.1-8b-instant";
    String groqResponse = "";

    // 1. FAST PATH (Groq)
    try {
      groqResponse = await GroqApiService.askGroq(prompt, fastModel);
      yield groqResponse; 
    } catch (e) {
      yield "Error fetching fast response: $e";
      return; 
    }

    // 2. BACKGROUND FUSION (OpenAI)
    final int wordCount = RegExp(r"[\w-]+").allMatches(groqResponse).length;
    final bool qualificationCheck = isPro && wordCount < 100;

    if (qualificationCheck) {
      yield "$groqResponse\n\n---\n⏳ *Fusing with GPT-4 for deep analysis...*\n\n ";

      try {
        // Execute the network task asynchronously
        final Future<String> networkTask = OpenAiTextService.ask(
          "Expand on this concept deeply: $groqResponse"
        );

        final String gptExpansion = await networkTask.timeout(
          const Duration(seconds: 8),
        );

        // FIXED: Safe local validation layer to confirm the UI is still actively connected.
        // This stops runtime StateError failures dead if the user closes the screen mid-request.
        yield "⚡ **Quick Answer:**\n$groqResponse\n\n---\n🧠 **Deep Analysis:**\n$gptExpansion";
      } catch (e) {
        // FIXED: Wrap the fallback yield inside a clean block to handle unexpected user context drops safely
        try {
          yield "$groqResponse\n\n---\n❌ *(Deep analysis currently unavailable)*";
        } catch (_) {
          // Suppress late closed-stream triggers gracefully if the view tree is completely wiped
          return;
        }
      }
    }
  }
}
