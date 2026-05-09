class AdFrequencyCapper {
  static int _adsShown = 0;
  
  static bool canShowAd() {
    if (_adsShown > 10) return false; // Max 10 interstitial ads per session
    _adsShown++;
    return true;
  }
}