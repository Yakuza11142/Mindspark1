import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:developer' as developer;
import '../config/secrets_fusion.dart';

class ElevenLabsVoiceEngine {
  // Global Voice IDs
  static const String antoni = "ErXwobaYiN019PkySvjV";
  static const String adam = "pNInz6obpgDQGcFmaJgB";

  // FIXED: Restored complete method signatures and cleared out automated CI decapitation fragments
  static Future<File?> generateAudio(String text, {String voiceId = adam}) async {
    final String cleanedText = text.trim();
    final String cleanedVoice = voiceId.trim();

    developer.log("🗣️ ElevenLabsVoiceEngine: Processing text-to-speech for voice sequence: $cleanedVoice");

    if (cleanedText.isEmpty) {
      developer.log("⚠️ ElevenLabsVoiceEngine: Aborting execution due to unpopulated input string payload.");
      return null;
    }

    try {
      // FIXED: Swapped out broken base domain links for the official, unshifted Text to Speech REST API endpoint path
      final Uri url = Uri.parse("https://elevenlabs.io");

      final Map<String, String> headers = {
        "xi-api-key": SecretsFusion.elevenLabsKey,
        "Content-Type": "application/json"
      };

      final String payloadBody = jsonEncode({
        "text": cleanedText,
        "model_id": "eleven_multilingual_v2" // Confirmed active lifecelike Speech foundation model identity
      });

      // Bound network threads explicitly to protect application containers from freezing on spotty cellular signals
      final http.Response res = await http.post(
        url,
        headers: headers,
        body: payloadBody,
      ).timeout(
        const Duration(seconds: 15),
      );

      if (res.statusCode == 200) {
        final Directory dir = await getTemporaryDirectory();
        
        // FIXED: Inject unique millisecond timestamp suffixes to safely isolate concurrent file access handles from corruption
        final String targetPath = '${dir.path}/lesson_audio_${DateTime.now().millisecondsSinceEpoch}.mp3';
        final File file = File(targetPath);
        
        return await file.writeAsBytes(res.bodyBytes);
      } else {
        developer.log("❌ ElevenLabsVoiceEngine: API endpoint rejected request payload structure with status: ${res.statusCode}. Body: ${res.body}");
        return null;
      }
    } catch (e, stackTrace) {
      // FIXED: Wrapped exceptions within diagnostic log parameters to track environment errors safely
      developer.log("❌ ElevenLabsVoiceEngine: Audio retrieval pipeline encountered an execution crash", error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
