import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class DynamicTranslations {
  static final Map<String, Map<String, String>> _cache = {};

  static Future<String> getText(String key, String englishText, String targetLang) async {
    if (targetLang == 'en') return englishText;
    
    // Check Cache
    if (_cache.containsKey(targetLang) && _cache[targetLang]!.containsKey(key)) {
      return _cache[targetLang]![key]!;
    }

    // Call API if not cached
    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: Secrets.geminiKey);
      final res = await model.generateContent([Content.text("Translate to $targetLang concisely: '$englishText'")]);
      String translated = res.text ?? englishText;
      
      // Save to cache
      _cache.putIfAbsent(targetLang, () => {})[key] = translated;
      return translated;
    } catch (e) {
      return englishText; // Fallback
    }
  }
}