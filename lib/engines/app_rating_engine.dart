import 'package:in_app_review/in_app_review.dart';
import 'dart:developer' as developer;
import 'app_rating_logic_gate.dart'; 

class AppRatingEngine {
  static final InAppReview _reviewInstance = InAppReview.instance;

  /// Safely presents the native App Store / Google Play rating interface if conditions align [INDEX]
  static Future<void> askForStarsIfHappy({
    required int quizScore,
    required int currentSparksCount,
    required String activeAppVersion,
  }) async {
    if (quizScore < 90) return; // Exit early if performance threshold parameters are unmet

    developer.log("⭐️ AppRatingEngine: High quiz score detected ($quizScore%). Checking persistent throttling gates.");

    try {
      // 1. Check preference limits first to save expensive native hardware window allocations [INDEX]
      final bool isGateApproved = await AppRatingLogicGate.shouldAskForReview(
        currentSparksCount: currentSparksCount,
        activeAppVersion: activeAppVersion,
      );

      if (!isGateApproved) {
        developer.log("🛡️ AppRatingEngine: Throttling gate rejected request context. Aborting popup display.");
        return;
      }

      // 2. Query low-level native operating system availability markers safely [INDEX]
      final bool isHardwareAvailable = await _reviewInstance.isAvailable();
      if (!isHardwareAvailable) {
        developer.log("⚠️ AppRatingEngine: Native device store review microservice is currently unavailable on this platform.");
        return;
      }

      developer.log("🚀 AppRatingEngine: Launching native platform review presentation window.");
      
      // Attached an explicit await marker to hold thread frames securely during execution allocations [INDEX]
      await _reviewInstance.requestReview();
      
      // Permanently log the successful event down your storage data slots to prevent immediate re-prompt loops [INDEX]
      await AppRatingLogicGate.logSuccessfulPromptDisplay(activeAppVersion);
      
    } catch (e, stackTrace) {
      developer.log("❌ AppRatingEngine: Native platform dialog invocation collapsed smoothly", error: e, stackTrace: stackTrace);
    }
  }
}
