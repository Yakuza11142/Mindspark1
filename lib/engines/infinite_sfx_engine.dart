import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../config/secrets.dart'; // Make sure your ElevenLabs key is here

class InfiniteSfxEngine {
  static final AudioPlayer _player = AudioPlayer();

  // THE INFINITE SOUND GENERATOR
  static Future<void> generateAndPlaySound(String soundDescription) async {
    print("🎧 Synthesizing audio reality for: $soundDescription...");

    try {
      // 1. Ping the ElevenLabs Sound Effects API
      final response = await http.post(
        Uri.parse("https://api.elevenlabs.io/v1/sound-generation"),
        headers: {
          "xi-api-key": Secrets.elevenLabsKey,
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "text": soundDescription, // e.g., "A volcano erupting violently", "A lion roaring in the savanna"
          "duration_seconds": 4,    // Keep it short to save API costs
          "prompt_influence": 0.3   // How strictly it follows your text
        }),
      );

      if (response.statusCode == 200) {
        // 2. Save the raw audio bytes to the phone's temporary RAM/Storage
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/dynamic_sfx_${DateTime.now().millisecondsSinceEpoch}.mp3');
        await file.writeAsBytes(response.bodyBytes);

        // 3. Play the generated sound instantly
        await _player.play(DeviceFileSource(file.path), volume: 0.8);
        print("✅ Sound reality synthesized.");
      } else {
        print("❌ Audio Synthesis Failed: ${response.body}");
      }
    } catch (e) {
      print("Network drop during audio synthesis.");
    }
  }
}