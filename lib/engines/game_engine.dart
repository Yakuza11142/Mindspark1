import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class GameEngine {
  late GenerativeModel _model;

  GameEngine() {
    _model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
  }

  // GENERATE FLASHCARDS
  Future<List<Map<String, String>>> generateFlashcards(String topic) async {
    final prompt = "Create 5 flashcards for '$topic'. JSON format: [{'front': 'Question', 'back': 'Answer'}]. No markdown.";
    try {
      final res = await _model.generateContent([Content.text(prompt)]);
      String clean = res.text!.replaceAll('```json', '').replaceAll('```', '');
      List<dynamic> data = jsonDecode(clean);
      return data.map((e) => {'front': e['front'].toString(), 'back': e['back'].toString()}).toList();
    } catch (e) {
      return [{'front': 'Error', 'back': 'Try again'}];
    }
  }
}