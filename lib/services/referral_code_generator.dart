import 'dart:math';

class ReferralCodeGenerator {
  static String createCode(String userName) {
    String rand = (Random().nextInt(9000) + 1000).toString();
    return "${userName.substring(0, 3).toUpperCase()}$rand";
  }
}