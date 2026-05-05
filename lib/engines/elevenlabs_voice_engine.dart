class ElevenLabsVoiceEngine {
  // Global Voice IDs
  static const String antoni = "ErXwobaYiN019PkySvjV";
  static const String adam = "pNInz6obpgDQGcFmaJgB";

  static Future<File?> generateAudio(String text, {String voiceId = adam}) async {
    try {
      final res = await http.post(
        Uri.parse("https://elevenlabs.io"),
        headers: {
          "xi-api-key": SecretsFusion.elevenLabsKey, 
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "text": text, 
          "model_id": "eleven_multilingual_v2" // Using v2 for better global quality
        }),
      );
      
      if (res.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/lesson_audio.mp3');
        return await file.writeAsBytes(res.bodyBytes);
      }
    } catch (e) { 
      debugPrint("Audio Error: $e"); 
    }
    return null;
  }
}
