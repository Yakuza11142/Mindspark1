import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../config/secrets.dart';

class AdManager {
  InterstitialAd? _interstitialAd;
  RewardedInterstitialAd? _rewardedAd;
  static int _count = 0;

  void init() {
    MobileAds.instance.initialize();
    _loadAll();
  }

  void _loadAll() {
    InterstitialAd.load(
      adUnitId: Secrets.interstitialId, request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) => _interstitialAd = ad, onAdFailedToLoad: (e) => _interstitialAd = null)
    );
    RewardedInterstitialAd.load(
      adUnitId: Secrets.rewardedId, request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(onAdLoaded: (ad) => _rewardedAd = ad, onAdFailedToLoad: (e) => _rewardedAd = null)
    );
  }

  BannerAd createBanner() {
    return BannerAd(adUnitId: Secrets.bannerId, size: AdSize.banner, request: const AdRequest(), listener: BannerAdListener(onAdFailedToLoad: (ad, e) => ad.dispose()));
  }

  void showSmartInterstitial() {
    _count++;
    if (_count % 2 != 0) return;
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
      _loadAll();
    }
  }

  void showRewarded(Function onReward) {
    if (_rewardedAd != null) {
      _rewardedAd!.show(onUserEarnedReward: (ad, item) => onReward());
      _rewardedAd = null;
      _loadAll();
    } else {
      onReward();
    }
  }
}