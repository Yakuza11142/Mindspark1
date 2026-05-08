import 'package:share_plus/share_plus.dart';

class FriendChallengeService {
  static void sendChallenge(String topic, int yourScore) {
    String msg = "I scored $yourScore points on '$topic' in MindSpark! Bet you can't beat me. ⚡ Try here: https://mindspark.app/challenge";
    Share.share(msg);
  }
}