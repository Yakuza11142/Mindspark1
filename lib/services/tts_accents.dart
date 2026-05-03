import 'package:flutter_tts/flutter_tts.dart';

class TtsGlobalManager {
  /// Globally configures voice based on any country code provided.
  /// If no match is found, it falls back to a standard clear voice.
  static Future<void> configureVoice(FlutterTts tts, String countryCode) async {
    List<dynamic> voices = await tts.getVoices;
    
    for (var voice in voices) {
      // Matches any country code passed (e.g., 'US', 'GB', 'NG', 'IN', 'JP')
      if (voice["locale"].contains(countryCode.toUpperCase())) {
        await tts.setVoice({"name": voice["name"], "locale": voice["locale"]});
        break;
      }
    }
    
    await tts.setSpeechRate(0.5); 
    await tts.setPitch(1.0);
  }
}
