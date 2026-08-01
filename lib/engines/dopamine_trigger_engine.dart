import 'dart:math';
import 'dart:developer' as developer;

class DopamineTriggerEngine {
  // Cached a single cryptographically secure random generator instance to maximize heap efficiency
  static final Random _secureRandom = Random.secure();

  // Explicit mathematical transaction caps protect database ledger thresholds from integer overflows
  static const int maxBaseRewardCap = 100000; 
  static const int maxTotalRewardCap = 1000000;

  // Extracted probability thresholds into clean constants to prepare for dynamic configuration setups
  static const int jackpotThreshold = 5;       // 5% chance (0-4)
  static const int doubleBonusThreshold = 20;  // 15% chance (5-19)

  /// Calculates random reward multipliers securely. 
  /// NOTE: For commercial currency logic, wrap this inside a remote server function execution pipeline.
  static int calculateRandomReward(int baseReward) {
    // Rigid input boundaries reject negative, unpopulated, or suspiciously inflated integers early
    if (baseReward <= 0 || baseReward > maxBaseRewardCap) {
      developer.log("⚠️ DopamineEngine: Aborting reward calculations due to out-of-bounds parameter context [$baseReward].");
      return 0;
    }

    final int roll = _secureRandom.nextInt(100);
    int finalCalculatedReward = baseReward;

    // Formulated explicit, independent logic boundaries to safely shield your math when adding luck states
    if (roll < jackpotThreshold) {
      developer.log("🎰 DopamineEngine: JACKPOT TRIGGERED! User receives 10x Sparks calculation mapping.");
      finalCalculatedReward = baseReward * 10;
    } else if (roll >= jackpotThreshold && roll < doubleBonusThreshold) {
      developer.log("🔥 DopamineEngine: DOUBLE BONUS TRIGGERED! Appending reward multiplier scaling.");
      finalCalculatedReward = baseReward * 2;
    } else {
      developer.log("💎 DopamineEngine: Standard reward applied across baseline operations.");
    }

    // Enforce a strict safe absolute cap limit before returning values back to application states
    if (finalCalculatedReward > maxTotalRewardCap) {
      developer.log("🛡️ DopamineEngine: Calculated reward exceeded system absolute threshold. Clamping to maximum limit bounds.");
      return maxTotalRewardCap;
    }

    return finalCalculatedReward;
  }
}
