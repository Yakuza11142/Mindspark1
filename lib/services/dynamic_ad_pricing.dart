class DynamicAdPricing {
  static String getAdUnitId() {
    int hour = DateTime.now().hour;
    // Between 4 PM and 8 PM, we only accept high-eCPM ads because traffic is guaranteed
    if (hour >= 16 && hour <= 20) {
      return "ca-app-pub-6212928709769131/HIGH_TIER_ID";
    }
    return "ca-app-pub-6212928709769131/STANDARD_ID";
  }
}