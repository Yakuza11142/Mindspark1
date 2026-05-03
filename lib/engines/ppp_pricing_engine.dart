class PppPricingEngine {
  static double getOptimalPriceUsd(String isoCode) {
    // Tier 1: High Income ($9.99)
    if (["US", "CA", "GB", "AU", "DE", "FR", "JP", "AE"].contains(isoCode)) return 9.99;
    
    // Tier 2: Medium Income ($5.99)
    if (["BR", "MX", "ZA", "RU", "TR", "MY"].contains(isoCode)) return 5.99;
    
    // Tier 3: Emerging Markets ($2.99 - Volume Play)
    if (["NG", "IN", "KE", "GH", "EG", "PK", "ID"].contains(isoCode)) return 2.99;
    
    return 9.99; // Default global fallback
  }
}