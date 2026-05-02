class CinematicFusionEngine {
  // Static flag to control the loop if needed
  static bool _isRunning = true;

  static Stream<Map<String, String>> generateInfinite(String topic, String teacherScript) async* {
    while (_isRunning) {
      // 1. Generate URLs (Runway & HeyGen APIs)
      String backgroundUrl = "https://mock-runway-api.com{DateTime.now().millisecondsSinceEpoch}.mp4";
      String teacherUrl = "https://mock-heygen-api.com{DateTime.now().millisecondsSinceEpoch}.mp4";
      
      yield {"background": backgroundUrl, "teacher": teacherUrl};
      
      // Brief delay to prevent API rate limiting
      await Future.delayed(Duration(seconds: 10)); 
    }
  }
}
