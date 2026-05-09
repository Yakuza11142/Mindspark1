class ChallengeService {
  static String createChallengeLink(String topic, int score) {
    return "https://mindspark.app/challenge?topic=$topic&score=$score";
  }
}