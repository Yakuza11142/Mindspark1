import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class AppRatingLogicGate {
  static const String _lastPromptedVersionKey = 'app_review_last_version_prompted';
  static const String _historicalPromptCountKey = 'app_review_total_prompt_count';

  /// Evaluates whether the application can safely request a store review without breaching compliance rules
  static Future<bool> shouldAskForReview({
    required int currentSparksCount,
    required String activeAppVersion,
  }) async {
    final String cleanedVersion = activeAppVersion.trim();
    if (cleanedVersion.isEmpty || currentSparksCount <= 500) {
      return false; 
    }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // Enforce strict single-prompt constraints per semantic application release version build
      final String? lastPromptedVersion = prefs.getString(_lastPromptedVersionKey);
      if (lastPromptedVersion == cleanedVersion) {
        developer.log("🛡️ RatingGate: Review prompt blocked. Already displayed once within app version: $cleanedVersion");
        return false;
      }

      // Boundary lock throttling logic (e.g., maximum limit of 3 prompt attempts total per user lifetime)
      final int totalLifetimePrompts = prefs.getInt(_historicalPromptCountKey) ?? 0;
      if (totalLifetimePrompts >= 3) {
        developer.log("🛡️ RatingGate: Absolute lifetime review frequency threshold reached ($totalLifetimePrompts attempts). Silencing permanently.");
        return false;
      }

      developer.log("🎰 RatingGate: Target milestones achieved. Review request context approved.");
      return true;
    } catch (e, stackTrace) {
      developer.log("❌ RatingGate: Persistent preference read crash captured seamlessly", error: e, stackTrace: stackTrace);
      return false; 
    }
  }

  /// Call this confirmation latch method the exact millisecond you trigger the native system review manager utility
  static Future<void> logSuccessfulPromptDisplay(String activeAppVersion) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int currentCount = prefs.getInt(_historicalPromptCountKey) ?? 0;

      // Bundled sequential write statements into Future.wait to execute simultaneously and block transaction split errors
      await Future.wait([
        prefs.setString(_lastPromptedVersionKey, activeAppVersion.trim()),
        prefs.setInt(_historicalPromptCountKey, currentCount + 1),
      ]);
      
      developer.log("✅ RatingGate: Review event logged. Lifetime attempts incremented to: ${currentCount + 1}");
    } catch (e) {
      developer.log("Error writing review metrics to disk: $e");
    }
  }
}
