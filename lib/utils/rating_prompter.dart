import 'package:in_app_review/in_app_review.dart';

class RatingPrompter {
  static void ask() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }
}