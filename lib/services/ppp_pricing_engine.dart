class PppPricingEngine {
  static double getLocalPrice(String countryCode) {
    // Base price is $9.99
    if (countryCode == 'IN') return 2.99; // India
    if (countryCode == 'NG') return 2.99; // Nigeria
    if (countryCode == 'BR') return 3.99; // Brazil
    if (countryCode == 'GB') return 11.99; // UK
    return 9.99; // US & Global Default
  }
}