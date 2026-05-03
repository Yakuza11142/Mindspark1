import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/video_secrets_v2.dart';

class RunwayBRollEngine {
  static Future<String?> generateCutaway(String topic) async {
    print("🎬 Runway Gen-3: Generating B-Roll for $topic");
    try {
      final res = await http.post(
        Uri.parse("https://api.runwayml.com/v1/generate"),
        headers: {"Authorization": "Bearer ${VideoSecretsV2.runwayKey}", "Content-Type": "application/json"},
        body: jsonEncode({"prompt": "Cinematic, hyper-realistic, 4k educational shot of $topic"})
      );
      return jsonDecode(res.body)['video_url'];
    } catch (e) { return null; }
  }
}