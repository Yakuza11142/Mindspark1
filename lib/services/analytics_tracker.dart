import 'package:supabase_analytics/supabase_analytics.dart';

class AnalyticsTracker {
  static final SupabaseAnalytics _analytics = SupabaseAnalytics.instance;

  static void logLesson(String topic) {
    _analytics.logEvent(
      name: "lesson_started",
      parameters: {"topic": topic},
    );
  }

  static void logPurchase() {
    _analytics.logEvent(name: "purchase_complete");
  }
}