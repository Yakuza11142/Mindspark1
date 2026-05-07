import 'package:in_app_review/in_app_review.dart';

class AppRatingEngine {
  static Future<void> askForStarsIfHappy(int quizScore) async {
    if (quizScore >= 90) {
      if (await InAppReview.instance.isAvailable()) {
        InAppReview.instance.requestReview();
      }
    }
  }
}