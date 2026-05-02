class PastQuestionAnalyzer {
  static List<String> getHighlyRepeatedTopics(String subject) {
    if (subject == "Physics") {
      return["Radioactivity (Repeated 12 times)", "Waves (Repeated 9 times)", "Logic Gates (Repeated 8 times)"];
    }
    return ["General Revision"];
  }
}