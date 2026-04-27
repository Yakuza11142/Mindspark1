import 'package:dio/dio.dart';
import 'package:dart_openai/dart_openai.dart';
import '../config/secrets.dart';
import 'tripo_engine.dart';

class MediaEngine {
  final Dio _dio = Dio();
  final TripoEngine _tripo = TripoEngine();

  Future<Map<String, dynamic>> fetchVisuals(String topic, bool isPro) async {
    // 1. PEXELS
    try {
      final res = await _dio.get(
        "https://api.pexels.com/videos/search",
        queryParameters: {'query': topic, 'per_page': 1, 'orientation': 'landscape', 'size': 'medium'},
        options: Options(headers: {"Authorization": Secrets.pexelsKey})
      );
      if (res.data['videos'].isNotEmpty) {
        return {'type': 'VIDEO', 'url': res.data['videos'][0]['video_files'][0]['link']};
      }
    } catch (e) {}

    // 2. TRIPO 3D (Async start)
    if (isPro) {
      _tripo.generate3D(topic); // Start generation, handle via UI future
    }

    // 3. DALL-E
    try {
      final img = await OpenAI.instance.image.create(
        prompt: "Educational diagram of $topic", model: "dall-e-3", size: OpenAIImageSize.size1024
      );
      return {'type': 'IMAGE', 'url': img.data.first.url};
    } catch (e) { return {'type': 'IMAGE', 'url': "https://via.placeholder.com/1080"}; }
  }
}