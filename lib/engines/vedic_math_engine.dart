import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class VedicMathEngine {
  static Future<String> generateTrick(String topic) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = """
    Teach a specific Vedic Math speed trick for: $topic. 
    Explain the 'Sutra' (rule), give a step-by-step example, and provide 1 practice question. 
    Keep it extremely fast and simple for a student preparing for a timed CBT exam.
    """;
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      return res.text ?? "Error loading Vedic Math trick.";
    } catch (e) {
      return "Network Error.";
    }
  }
}