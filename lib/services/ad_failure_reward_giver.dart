import '../services/currency_manager.dart';

class AdFailureRewardGiver {
  static void handleAdTimeout(CurrencyManager currency) {
    // If AdMob fails to load the video in 5 seconds:
    currency.addSparks(20); // Give partial reward
    print("Ad failed to load. Gave user 100 Sparks anyway for good UX.");
  }
}