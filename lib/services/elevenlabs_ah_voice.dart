import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../config/secrets_fusion.dart';

class ElevenLabsAhVoice {
  static Future<File?> speakLikeHuman(String ssmlText, String voiceId) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.elevenlabs.io/v1/text-to-speech/$voiceId"),
        headers: {"xi-api-key": SecretsFusion.elevenLabsKey, "Content-Type": "application/json"},
        body: jsonEncode({
          "text": ssmlText,
          "model_id": "eleven_monolingual_v1",
          "voice_settings": {"stability": 0.4, "similarity_boost": 0.85} // Lower stability = more human emotion
        }),
      );

      if (res.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/ah_voice_response.mp3');
        return await file.writeAsBytes(res.bodyBytes);
      }
    } catch (e) { print("Audio Error."); }
    return null;
  }
}