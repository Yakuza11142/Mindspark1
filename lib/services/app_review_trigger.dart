import 'package:in_app_review/in_app_review.dart';

class AppReviewTrigger {
  static void trigger() async {
    if (await InAppReview.instance.isAvailable()) {
      InAppReview.instance.requestReview();
    }
  }
}