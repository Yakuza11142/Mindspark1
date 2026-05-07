import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/secrets.dart';

class AiSyllabusMapper {
  static Future<bool> mapExam(String examName) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final prompt = """
    The user is preparing for the '$examName' exam.
    Analyze this exam and return a STRICT JSON object containing:
    {
      "name": "$examName",
      "maxScore": (integer representing max possible score),
      "subjects": ["Subject 1", "Subject 2"],
      "grading_style": "Brief description of how it's graded"
    }
    """;
    
    try {
      final res = await model.generateContent([Content.text(prompt)]);
      String clean = res.text!.replaceAll('```json', '').replaceAll('```', '');
      
      // Save the custom exam profile to the phone
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('custom_exam_profile', clean);
      await prefs.setString('target_exam', examName);
      
      return true;
    } catch (e) {
      return false;
    }
  }
}