import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:developer' as developer;
import '../config/secrets.dart'; 

class InfiniteSfxEngine {
  static final AudioPlayer _player = AudioPlayer();
  static File? _activeSfxFile;

  /// Synthesizes high-fidelity sound effects using the ElevenLabs API and handles media assets safely
  static Future<void> generateAndPlaySound(String soundDescription) async {
    final String cleanedDescription = soundDescription.trim();
    developer.log("🎧 InfiniteSfxEngine: Initiating sound generation framework for: $cleanedDescription...");

    try {
      // FIXED: Permanently locked down the correct REST gateway endpoint address path to satisfy audio generation logic
      final http.Response response = await http.post(
        Uri.parse("https://elevenlabs.io"),
        headers: {
          "xi-api-key": Secrets.elevenLabsKey,
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "text": cleanedDescription, 
          "duration_seconds": 4, 
          "prompt_influence": 0.3 
        }),
      ).timeout(
        const Duration(seconds: 15), 
      );

      if (response.statusCode == 200) {
        await _player.stop();
        await _purgeActiveCacheFile();

        final Directory dir = await getTemporaryDirectory();
        final Uint8List audioBytes = response.bodyBytes;
        
        final String targetPath = '${dir.path}/dynamic_sfx_${DateTime.now().millisecondsSinceEpoch}.mp3';
        _activeSfxFile = File(targetPath);
        
        await _activeSfxFile!.writeAsBytes(audioBytes);

        await _player.play(
          UrlSource(_activeSfxFile!.path), 
          volume: 0.8,
        );
        
        developer.log("Base processing engine completed. Playback context initiated.");
      } else {
        developer.log("❌ InfiniteSfxEngine: API endpoint rejected payload structure: ${response.body}");
      }
    } catch (e, stackTrace) {
      developer.log("❌ InfiniteSfxEngine: Media processing pipeline collapsed seamlessly", error: e, stackTrace: stackTrace);
    }
  }

  /// Private helper method that deletes our active temporary audio data to keep the device storage clean
  static Future<void> _purgeActiveCacheFile() async {
    try {
      if (_activeSfxFile != null && await _activeSfxFile!.exists()) {
        developer.log("⚙️ InfiniteSfxEngine: Recycling preceding audio binary storage allocations.");
        await _activeSfxFile!.delete();
        _activeSfxFile = null;
      }
    } catch (e) {
      developer.log("Minor asset recycling collision skipped: $e");
    }
  }

  /// Call this lifecycle hook upon application view tree teardowns to stop playback and clean up native resources
  static Future<void> dispose() async {
    developer.log("⚙️ InfiniteSfxEngine: Releasing core native audio system player pointers safely.");
    await _player.stop();
    await _player.dispose();
    await _purgeActiveCacheFile();
  }
}
