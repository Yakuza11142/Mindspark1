class UniversalTranslatorFallback {
  static const Map<String, String> fr = {"Explore": "Explorer", "Library": "Bibliothèque", "Rank": "Classement", "Me": "Moi"};
  
  static String translateUI(String key, String langCode) {
    if (langCode == 'fr') return fr[key] ?? key;
    return key;
  }
}