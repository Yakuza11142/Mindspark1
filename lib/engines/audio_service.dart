import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../config/secrets.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> speak(String text) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.elevenlabs.io/v1/text-to-speech/${Secrets.voiceId}"),
        headers: {"xi-api-key": Secrets.elevenLabsKey, "Content-Type": "application/json"},
        body: jsonEncode({"text": text, "model_id": "eleven_monolingual_v1"}),
      );
      if (res.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/voice.mp3');
        await file.writeAsBytes(res.bodyBytes);
        await _audioPlayer.play(DeviceFileSource(file.path));
      }
    } catch (e) {}
  }
  void stop() => _audioPlayer.stop();
}