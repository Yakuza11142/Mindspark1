import 'groq_api_service.dart';
import 'openai_text_service.dart';

class SeamlessFusionRouter {
  // Singleton pattern for global state management
  SeamlessFusionRouter._internal();
  static final SeamlessFusionRouter instance = SeamlessFusionRouter._internal();

  /// Infinite Fusion Logic: Uses Stream for 0.0000s perceived delay
  static Stream<String> streamBestResponse(String prompt, bool isPro) async* {
    // 1. FAST PATH (Groq): Yield immediately to the UI
    String fastModel = isPro ? "llama3-70b-8192" : "llama3-8b-8192";
    String groqResponse = "";

    try {
      groqResponse = await GroqApiService.askGroq(prompt, fastModel);
      yield groqResponse; // This hits the UI instantly
    } catch (e) {
      yield "Error fetching fast response: $e";
      return;
    }

    // 2. BACKGROUND FUSION (OpenAI): Only triggers for Pro + Short responses
    if (isPro && groqResponse.split(' ').length < 100) {
      try {
        // We don't block the UI; we yield a placeholder then the final expansion
        yield "$groqResponse\n\n[Fusing with GPT-4 for depth...]";
        
        String gptExpansion = await OpenAiTextService.ask(
          "Expand on this concept deeply: $groqResponse"
        );

        // Final Yield: The complete infinite-depth response
        yield "⚡ **Quick Answer:**\n$groqResponse\n\n🧠 **Deep Dive:**\n$gptExpansion";
      } catch (e) {
        // Fallback: If OpenAI fails, the user still has the Groq answer
        yield groqResponse;
      }
    }
  }
}
