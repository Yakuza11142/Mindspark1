import 'groq_service.dart';
import 'openai_text_service.dart';

class AiFusionEngine {
  static Future<String> generateFusedLesson(String topic) async {
    // Run both APIs at the exact same time
    var results = await Future.wait([
      GroqService.ask("Give a hyper-fast, highly structured bullet-point breakdown of $topic."),
      OpenAiTextService.ask("Give a deep, cinematic, historical context and real-world application for $topic.")
    ]);

    String fastStructure = results[0];
    String deepContext = results[1];

    return "⚡ **CORE BREAKDOWN (Groq LPU)**\n$fastStructure\n\n🧠 **DEEP CONTEXT (GPT-5.5)**\n$deepContext";
  }
}