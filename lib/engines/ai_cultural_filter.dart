class AiCulturalFilter {
  static String injectCulture(String basePrompt, String countryCode) {
    if (countryCode == 'NG') return "$basePrompt[Use Nigerian examples like Danfo buses, Naira, and Lagos geography.]";
    if (countryCode == 'US') return "$basePrompt [Use American examples like Baseball, Dollars, and US History.]";
    return basePrompt;
  }
}