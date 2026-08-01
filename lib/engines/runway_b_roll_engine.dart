import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:developer' as developer;
import '../config/video_secrets_v2.dart';

class RunwayBRollEngine {
  // FIXED: Adjusted to use the correct API root route to prevent 404/Parsing crashes
  static const String _baseUrl = "https://runwayml.com";

  /// Generates B-Roll footage asynchronously using valid tracking tasks and polling wrappers
  static Future<String?> generateCutaway(String topic) async {
    developer.log("🎬 Runway Engine: Creating task initialization for $topic");
    
    try {
      // 1. Establish the Outbound Task Creation Request
      final http.Response taskCreationResponse = await http.post(
        Uri.parse("$_baseUrl/tasks"), 
        headers: {
          "Authorization": "Bearer ${VideoSecretsV2.runwayKey}", 
          "Content-Type": "application/json",
          "X-Runway-Version": "2025-01-15" 
        },
        body: jsonEncode({
          "taskType": "text_to_video", 
          "model": "gen4.5", 
          "promptText": "Cinematic, hyper-realistic, 4k educational shot of $topic",
          "ratio": "16:9" 
        }),
      );

      if (taskCreationResponse.statusCode != 201 && taskCreationResponse.statusCode != 200) {
        developer.log("Runway task initialization rejected: ${taskCreationResponse.body}");
        return null;
      }

      final Map<String, dynamic> taskData = jsonDecode(taskCreationResponse.body);
      final String? taskId = taskData['id'];

      if (taskId == null || taskId.isEmpty) {
        developer.log("Failed to extract target Task Identification from response schema.");
        return null;
      }

      // 2. Poll the Tracking Task until the Video Asset compiles on the cloud server
      return await _pollTaskStatus(taskId);
    } catch (e, stack) {
      developer.log("Runway B-Roll Pipeline collapsed due to unhandled loop mutation", error: e, stackTrace: stack);
      return null;
    }
  }

  /// Private polling daemon loop that watches the task status checkpoint securely
  static Future<String?> _pollTaskStatus(String taskId) async {
    final Uri statusUri = Uri.parse("$_baseUrl/tasks/$taskId");
    final Map<String, String> requestHeaders = {
      "Authorization": "Bearer ${VideoSecretsV2.runwayKey}",
      "Content-Type": "application/json",
      "X-Runway-Version": "2025-01-15"
    };

    // Bound loop iteration window protecting system execution memory pools
    for (int retryAttempt = 0; retryAttempt < 30; retryAttempt++) {
      await Future.delayed(const Duration(seconds: 4)); // 4-second delay keeps the network loop smooth
      
      try {
        final http.Response statusResponse = await http.get(statusUri, headers: requestHeaders);
        if (statusResponse.statusCode != 200) continue;

        final Map<String, dynamic> statusData = jsonDecode(statusResponse.body);
        final String status = statusData['status'] ?? 'PENDING';

        if (status == 'SUCCEEDED') {
          final dynamic output = statusData['output'];
          if (output != null) {
            if (output is List && output.isNotEmpty) {
              return output.first.toString();
            }
            if (output is Map && output['url'] != null) {
              return output['url'].toString();
            }
          }
          return null;
        }

        if (status == 'FAILED') {
          developer.log("Runway remote compilation cluster flagged failure on task processing.");
          return null;
        }
      } catch (e) {
        developer.log("Intermittent status polling frame timeout occurred.", error: e);
      }
    }
    
    developer.log("Runway tracking task sequence terminated prematurely due to timeout thresholds.");
    return null;
  }
}
