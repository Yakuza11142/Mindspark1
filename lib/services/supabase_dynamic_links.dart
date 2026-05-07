// Placeholder for AppLinks / Firebase Dynamic Links logic
class DynamicLinkService {
  static void init() {
    print("Listening for incoming deep links (e.g., mindspark://lesson/calculus)...");
  }

  static String generateShareLink(String topic) {
    return "https://mindspark.app/share?topic=${Uri.encodeComponent(topic)}";
  }
}