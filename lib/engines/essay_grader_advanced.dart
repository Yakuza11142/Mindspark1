import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class EssayGraderAdvanced {
  static Future<Map<String, dynamic>> gradeEssay(String essay) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = """
    Grade this essay out of 100. Return JSON strictly:
    {"grammar": 80, "content": 90, "structure": 75, "feedback": "Good job, but use more paragraphs."}
    Essay: "$essay"
    """;
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      String clean = res.text!.replaceAll('```json', '').replaceAll('```', '');
      return jsonDecode(clean);
    } catch (e) {
      return {"grammar": 0, "content": 0, "structure": 0, "feedback": "Error analyzing essay."};
    }
  }
}