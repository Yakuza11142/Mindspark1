import 'package:supabase_flutter/supabase_flutter.dart';

class AiVersionUpdater {
  static String activeOpenAiModel = "gpt-4-turbo"; // Default
  static String activeGeminiModel = "gemini-1.5-pro"; // Default
  static String activeGroqModel = "llama3-70b-8192"; // Default

  static Future<void> fetchLatestModels() async {
    try {
      // Connect to Supabase to see what you, the CEO, set as the newest model today
      final data = await Supabase.instance.client.from('system_config').select().single();
      
      activeOpenAiModel = data['openai_model'] ?? activeOpenAiModel;
      activeGeminiModel = data['gemini_model'] ?? activeGeminiModel;
      activeGroqModel = data['groq_model'] ?? activeGroqModel;
      
      print("🚀 AI Brains Synced: Using $activeOpenAiModel & $activeGeminiModel");
    } catch (e) {
      print("Offline: Falling back to default cached AI models.");
    }
  }
}