class CurrencyPppManager {
  static double getSubscriptionPriceUsd(String countryCode) {
    if (['NG', 'GH', 'KE'].contains(countryCode)) return 2.99; // African Tier
    if (['IN', 'PK', 'BD'].contains(countryCode)) return 1.99; // South Asian Tier
    if (['US', 'GB', 'CA', 'AU'].contains(countryCode)) return 9.99; // Western Tier
    return 4.99; // Global Average
  }
}