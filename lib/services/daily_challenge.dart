class DailyChallenge {
  static String getTodayChallenge() {
    int day = DateTime.now().day;
    List<String> tasks = [
      "Complete 1 Physics Lesson",
      "Get 100% on a Quiz",
      "Use the Holo-Deck once",
      "Learn a new word",
      "Earn 50 Sparks"
    ];
    return tasks[day % tasks.length];
  }
}