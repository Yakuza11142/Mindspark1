import '../models/language_model.dart';

class SupportedLanguages {
  static final List<LanguageModel> list =[
    LanguageModel("English", "en", "🇬🇧"),
    LanguageModel("Nigerian Pidgin", "pcm", "🇳🇬"),
    LanguageModel("Yoruba", "yo", "🇳🇬"),
    LanguageModel("Igbo", "ig", "🇳🇬"),
    LanguageModel("Hausa", "ha", "🇳🇬"),
    LanguageModel("Swahili", "sw", "🇰🇪"),
    LanguageModel("French", "fr", "🇫🇷"),
    LanguageModel("Mandarin", "zh", "🇨🇳"),
    LanguageModel("Ancient Sumerian", "sux", "🏛️"), // The ultimate flex
  ];
}