class FeedbackLoopService {
  static void logAiSkip(String topic) {
    print("Telemetry: User skipped AI response for $topic. Prompt may need tuning.");
  }
}