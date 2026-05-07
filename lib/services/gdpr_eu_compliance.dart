class GdprEuCompliance {
  static bool requiresConsent(String countryCode) {
    List<String> euCountries =['GB', 'FR', 'DE', 'IT', 'ES', 'NL']; // etc.
    return euCountries.contains(countryCode);
  }
  
  static void showConsentDialog() {
    print("Showing strict GDPR consent popup.");
  }
}