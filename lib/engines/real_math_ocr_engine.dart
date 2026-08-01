import 'dart:io';
import 'dart:convert'; 
import 'dart:typed_data'; 
import 'dart:isolate'; 
import 'package:flutter/foundation.dart'; 
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:developer' as developer;
import '../config/secrets.dart';

class RealMathOcrEngine {
  /// Scans a visual equation document and extracts a valid LaTeX string safely decoded from JSON payloads
  static Future<String> scanEquation(File imageFile) async {
    developer.log("🔮 Math OCR Engine: Initiating multimodal extraction tracking lifecycle.");
    
    try {
      final int fileLength = await imageFile.length();
      if (fileLength > 10 * 1024 * 1024) { 
        throw ArgumentError("Image resource file size exceeds safe processing limits. Compress the file before scanning.");
      }

      final GenerativeModel model = GenerativeModel(
        model: 'gemini-2.5-flash', 
        apiKey: Secrets.geminiKey,
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          responseSchema: Schema.object(
            properties: {
              'latex_equation': Schema.string(
                description: 'The clean extracted mathematical expression written strictly in valid LaTeX formatting syntax.',
              )
            },
            requiredProperties: ['latex_equation'],
          ),
        ),
      );

      // Safely executed file stream bytes ingestion on an isolated worker pool thread
      final Uint8List bytes = await Isolate.run(() => imageFile.readAsBytesSync());
      
      const String prompt = "Analyze this equation image and extract the exact mathematical structure into the requested JSON schema output format.";

      final GenerateContentResponse res = await model.generateContent([
        Content.multi([
          TextPart(prompt), 
          DataPart('image/jpeg', bytes) 
        ])
      ]).timeout(
        const Duration(seconds: 15), 
      );

      final String? responseText = res.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception("Upstream engine returned a null or empty text payload response container.");
      }

      final dynamic decodedPayload = jsonDecode(responseText);
      if (decodedPayload is! Map) {
        throw FormatException("Server returned an invalid JSON object format structure. Expected a Map container schema wrapper.");
      }

      final Map<String, dynamic> structuredJson = Map<String, dynamic>.from(decodedPayload);

      final String? finalEquation = structuredJson['latex_equation'] as String?;
      if (finalEquation == null || finalEquation.isEmpty) {
        throw Exception("Target 'latex_equation' parameter key value mapping returned blank or unpopulated.");
      }

      final String sanitizedEquation = finalEquation
          .replaceAll('\r', '') 
          .trim();

      return sanitizedEquation;
    } catch (e, stackTrace) {
      developer.log("Multimodal parsing pipeline encountered a critical extraction fault", error: e, stackTrace: stackTrace);
      return "Error reading equation.";
    }
  }
}
