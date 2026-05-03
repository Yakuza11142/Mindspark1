import 'package:share_plus/share_plus.dart';

class WhatsappShareHelper {
  static void shareScore(int score, String exam) {
    Share.share("I scored $score% on the MindSpark $exam Simulator! 🧠🚀 Can you beat me? Download at mindspark.app");
  }
}