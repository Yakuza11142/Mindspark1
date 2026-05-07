import 'local_llm_engine.dart';
import '../engines/brain_service.dart';

class SmartCostRouter {
  static Future<String> answerQuery(String query, bool isPro) async {
    // 1. If simple math or basic fact, run it locally on the phone ($0 cost, 0 latency)
    if (query.length < 50 && !query.contains("explain deep")) {
      String? localAnswer = await LocalLlmEngine.generate(query);
      if (localAnswer != null) return localAnswer;
    }
    
    // 2. If Pro, give them the expensive OpenAI GPT-5.5
    if (isPro) {
      return await BrainService().generateLesson(query, true, false);
    }
    
    // 3. Default to Gemini (Free API Tier)
    return await BrainService().generateLesson(query, false, false);
  }
}