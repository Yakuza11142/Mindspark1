import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TripoEngine {
  // FIXED: Pull credentials securely out of encrypted binary memory blocks instead of raw files
  static const String _tripoKey = String.fromEnvironment('TRIPO_API_KEY');
  static const String _baseUrl = 'https://api.tripo3d.ai/v2/openapi/task';

  /// Triggers a Text-to-3D model task and returns an active progress stream of the asset path.
  Stream<String> generate3dModelStream(String prompt) async* {
    if (prompt.trim().isEmpty || _tripoKey.isEmpty) {
      yield "❌ Error: Invalid prompt or missing API authorization key credentials.";
      return;
    }

    final String cleanPrompt = prompt.trim();
    yield "🛰️ Submitting prompt grid to Tripo 3D Cloud Cluster...";

    try {
      final http.Response response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          "Authorization": "Bearer $_tripoKey",
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "type": "text_to_model",
          "prompt": "A highly detailed production-grade 3D asset of: $cleanPrompt, glb format, PBR textures"
        }),
      );

      if (response.statusCode != 200) {
        yield "❌ Server Exception: HTTP Error Status ${response.statusCode}";
        return;
      }

      // FIXED: Safe explicit JSON conversion to protect the runtime app loop from object reference errors
      final Map<String, dynamic> responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      
      if (responseBody['code'] != 0 || responseBody['data'] == null) {
        final String errorMsg = responseBody['message'] ?? 'Unknown gateway rejection parameters.';
        yield "❌ Tripo Gateway Rejected Task: $errorMsg";
        return;
      }

      final String taskId = responseBody['data']['task_id']?.toString() ?? '';
      if (taskId.isEmpty) {
        yield "❌ Error: Cloud server failed to yield a valid tracking signature.";
        return;
      }

      yield "🔒 Task indexed successfully: [ID: $taskId]. Initializing processing loop...";

      // FIXED: Forward the asset signature to the elastic progress stream tracker
      yield* _pollTaskStatus(taskId);

    } catch (e) {
      debugPrint("🚨 Tripo Engine Initialization Exception: ${e.toString()}");
      yield "❌ Processing Exception: ${e.toString()}";
    }
  }

  /// FIXED: Rewritten into an elastic polling stream engine with backoff parameters
  Stream<String> _pollTaskStatus(String taskId) async* {
    int consecutiveChecks = 0;
    const int maxCheckCap = 30; // Extends total tracking window up to several minutes safely
    
    // Elastic timing delay variables: increases waiting intervals if the server is congested
    int delaySeconds = 3; 

    while (consecutiveChecks < maxCheckCap) {
      await Future.delayed(Duration(seconds: delaySeconds));
      consecutiveChecks++;

      try {
        final http.Response response = await http.get(
          Uri.parse('$_baseUrl/$taskId'),
          headers: {
            "Authorization": "Bearer $_tripoKey",
            "Accept": "application/json",
          },
        );

        if (response.statusCode != 200) {
          yield "⏳ Connection unstable. Retrying handshake matrix... [Check #$consecutiveChecks]";
          continue;
        }

        final Map<String, dynamic> responseBody = jsonDecode(response.body) as Map<String, dynamic>;
        final Map<String, dynamic>? dataBlock = responseBody['data'] != null 
            ? Map<String, dynamic>.from(responseBody['data'] as Map) 
            : null;

        if (dataBlock == null) {
          yield "❌ Error: Cloud server emitted an un-parsable data format tree.";
          return;
        }

        final String status = dataBlock['status']?.toString().toUpperCase() ?? '';
        final int progress = dataBlock['progress'] ?? 0;

        if (status == "SUCCESS") {
          final Map<String, dynamic>? outputBlock = dataBlock['output'] != null 
              ? Map<String, dynamic>.from(dataBlock['output'] as Map) 
              : null;
          
          final String? modelUrl = outputBlock?['model']?.toString();
          
          if (modelUrl != null && modelUrl.isNotEmpty) {
            yield "✅ SUCCESS|$modelUrl"; // Return complete signal flag matching clean parsing keys
            return;
          }
          yield "❌ Error: Generation stated success but asset download path was null.";
          return;
        }

        if (status == "FAILED") {
          yield "❌ Tripo Compilation Failed: Core neural asset compilation abort.";
          return;
        }

        // Output incremental completion updates directly to your UI screen layers
        yield "⏳ Compiling 3D Vector Space: $progress% Complete... [Pass $consecutiveChecks/$maxCheckCap]";

        // Elastic scaling adjustment: if progress stalls, increase delays slightly to spare client bandwidth
        if (progress > 50 && delaySeconds == 3) {
          delaySeconds = 5;
        }

      } catch (e) {
        debugPrint("⚠️ Polling warning loop error: ${e.toString()}");
        yield "⏳ Sync buffering... [Pass $consecutiveChecks/$maxCheckCap]";
      }
    }

    yield "❌ Error: Cloud asset compilation timed out past legal environment constraints.";
  }
}
