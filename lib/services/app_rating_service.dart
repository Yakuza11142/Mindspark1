import 'package:in_app_review/in_app_review.dart';

class AppRatingService {
  static void check(int successCount) async {
    if (successCount == 5) { // After 5 successful lessons
      if (await InAppReview.instance.isAvailable()) {
        InAppReview.instance.requestReview();
      }
    }
  }
}