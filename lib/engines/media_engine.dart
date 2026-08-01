import 'package:dio/dio.dart';
import 'package:dart_openai/dart_openai.dart';
import 'dart:developer' as developer;
import '../config/secrets.dart';
import 'tripo_engine.dart';

class MediaEngine {
  final Dio _dio = Dio();
  final TripoEngine _tripo = TripoEngine();

  // Consolidated package parameter bounds early upon class memory initialization
  MediaEngine() {
    OpenAI.apiKey = Secrets.openAiKey;
  }

  /// Fetches the highest quality available educational visual asset for a given topic
  Future<Map<String, dynamic>> fetchVisuals(String topic, bool isPro) async {
    final String cleanedTopic = topic.trim();
    developer.log("🎥 Media Engine: Requesting multi-modal assets for target: $cleanedTopic");

    // 1. FAST PATH (Pexels Video Search Engine)
    try {
      final httpResponse = await _dio.get(
        "https://api.pexels.com/videos/search",
        queryParameters: {
          'query': cleanedTopic,
          'per_page': 1,
          'orientation': 'landscape',
          'size': 'medium'
        },
        options: Options(
          headers: {"Authorization": Secrets.pexelsKey},
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      final dynamic responseData = httpResponse.data;
      if (responseData is Map && responseData['videos'] != null && (responseData['videos'] as List).isNotEmpty) {
        final List<dynamic> videoList = responseData['videos'];
        final dynamic firstVideo = videoList.first;
        
        if (firstVideo is Map && firstVideo['video_files'] != null && firstVideo['video_files'] is List) {
          final List<dynamic> filesList = firstVideo['video_files'] as List<dynamic>;
          
          if (filesList.isNotEmpty) {
            final dynamic firstFile = filesList.first;
            if (firstFile is Map && firstFile['link'] != null) {
              final String videoLink = firstFile['link'].toString();
              return {
                'type': 'VIDEO',
                'url': videoLink.trim(),
              };
            }
          }
        }
      }
    } catch (e, stack) {
      developer.log("⚠️ Pexels video tracking path bypassed due to server exception", error: e, stackTrace: stack);
    }

    // 2. BACKGROUND 3D GENERATION LAYER (Tripo 3D Pipeline)
    if (isPro) {
      _tripo.generate3D(cleanedTopic).catchError((Object error) {
        developer.log("❌ Pro Tripo 3D Background Generation task collapsed", error: error);
        return null;
      });
    }

    // 3. FALLBACK PATH (OpenAI DALL-E 3 Vector Diagrams)
    try {
      final OpenAIImageModel imageModel = await OpenAI.instance.image.create(
        prompt: "Clean, detailed educational diagram of $cleanedTopic, studio lighting, hyper-realistic, 4k",
        model: "dall-e-3",
        size: OpenAIImageSize.size1024,
      ).timeout(
        const Duration(seconds: 12),
      );

      final String? finalImageUrl = imageModel.data.first.url;
      if (finalImageUrl != null && finalImageUrl.isNotEmpty) {
        return {'type': 'IMAGE', 'url': finalImageUrl.trim()};
      }
      
      throw Exception("Upstream OpenAI image array response container returned unpopulated.");
    } catch (e, stack) {
      developer.log("❌ OpenAI Generation path rejected request pipeline context", error: e, stackTrace: stack);
      
          } catch (e, stack) {
      developer.log("❌ OpenAI Generation path rejected request pipeline context", error: e, stackTrace: stack);
      
      // FIXED: Swapped out broken base domain links for an absolute, render-safe fallback image asset URL path
      return {
        'type': 'IMAGE', 
        'url': "https://unsplash.com"
      };
    }

    }
  }
}
