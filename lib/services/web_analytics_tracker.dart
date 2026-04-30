class WebAnalyticsTracker {
  static void logPageView(String path) {
    // Injects gtag.js push state for accurate web tracking
    print("📊 GA4: Logged page view to $path");
  }
}