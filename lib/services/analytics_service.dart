import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  void logLessonStarted(String topic) {
    _analytics.logEvent(name: "lesson_start", parameters: {"topic": topic});
  }

  void logPurchaseClicked() {
    _analytics.logEvent(name: "purchase_click");
  }
}