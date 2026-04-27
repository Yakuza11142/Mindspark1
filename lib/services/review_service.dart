import 'package:in_app_review/in_app_review.dart'; // Add to pubspec

class ReviewService {
  final InAppReview _inAppReview = InAppReview.instance;

  Future<void> requestReview() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
    }
  }
}