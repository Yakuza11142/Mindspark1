import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobGlobalWaterfall {
  // Using test IDs for structure. Replace with real High, Medium, and All-Floor IDs in Prod.
  static const List<String> adUnits =[
    'ca-app-pub-3940256099942544/1033173712', // High eCPM Floor (e.g. $10)
    'ca-app-pub-3940256099942544/8691691433', // Medium eCPM Floor (e.g. $5)
    'ca-app-pub-3940256099942544/4411468910', // Global Fill (e.g. $0.10)
  ];

  static void loadWaterfallInterstitial(int index, Function(InterstitialAd) onLoaded) {
    if (index >= adUnits.length) return; // All failed

    InterstitialAd.load(
      adUnitId: adUnits[index],
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => onLoaded(ad),
        onAdFailedToLoad: (error) {
          print("Ad load failed for tier $index. Falling back to lower tier...");
          loadWaterfallInterstitial(index + 1, onLoaded); // Try next tier
        },
      ),
    );
  }
}