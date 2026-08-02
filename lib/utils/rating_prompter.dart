import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

class RatingPrompter {
  // Safe static instance preserves the core platform channel bridge allocation
  static final InAppReview _inAppReview = InAppReview.instance;

  /// Call this strictly when a user finishes a successful milestone (e.g., cleared an experiment)
  static Future<void> askForRating() async {
    try {
      // 1. Verify if the host OS ecosystem explicitly supports in-app reviews right now
      final bool isAvailable = await _inAppReview.isAvailable();
      
      if (isAvailable) {
        // 2. CRUCIAL: Await the platform channel response to ensure thread execution safety
        await _inAppReview.requestReview();
      }
    } catch (e) {
      // Graceful fallback prevents the application UI thread from crashing if store links are broken offline
      debugPrint("InAppReview Engine Warning: ${e.toString()}");
    }
  }
}
