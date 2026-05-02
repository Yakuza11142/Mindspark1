import 'dart:math';

class DopamineTriggerEngine {
  static int calculateRandomReward(int baseReward) {
    int roll = Random().nextInt(100);
    
    if (roll < 5) {
      // 5% chance for a MASSIVE JACKPOT
      print("🎰 JACKPOT TRIGGERED! User receives 10x Sparks.");
      return baseReward * 10;
    } else if (roll < 20) {
      // 15% chance for a Double Bonus
      print("🔥 DOUBLE BONUS TRIGGERED!");
      return baseReward * 2;
    }
    
    // 80% chance for normal reward
    return baseReward;
  }
}