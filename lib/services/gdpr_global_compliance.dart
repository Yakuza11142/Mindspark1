class GdprGlobalCompliance {
  static bool requiresCookieConsent(String countryCode) {
    List<String> euZone = ["GB", "FR", "DE", "IT", "ES", "NL", "IE"];
    return euZone.contains(countryCode);
  }
}