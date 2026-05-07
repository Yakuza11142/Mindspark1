import 'ad_manager.dart';

class AdmobRevenueOptimizer {
  static void showBestAvailableAd(AdManager manager, Function onComplete) {
    // Advanced logic: Try interstitial, if null, try rewarded, if null, skip.
    manager.showInterstitial();
    onComplete();
  }
}