import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class RealMathOcrEngine {
  static Future<String> scanEquation(File imageFile) async {
    final model = GenerativeModel(model: 'gemini-3.1-pro', apiKey: Secrets.geminiKey);
    final bytes = await imageFile.readAsBytes();
    final prompt = "Extract the mathematical equation from this image. Return ONLY the LaTeX formatted equation.";
    
    final res = await model.generateContent([
      Content.multi([TextPart(prompt), DataPart('image/jpeg', bytes)])
    ]);
    return res.text ?? "Error reading equation.";
  }
}