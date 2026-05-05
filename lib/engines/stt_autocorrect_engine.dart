import 'groq_api_service.dart';

class SttAutocorrectEngine {
  // 1. Private constructor to prevent external instantiation
  SttAutocorrectEngine._internal();

  // 2. The single, global instance
  static final SttAutocorrectEngine instance = SttAutocorrectEngine._internal();

  // 3. Keep static methods if you want direct access via class name
  static Future<String> cleanSpeech(String rawSpeech) async {
    // Escape single quotes to prevent prompt injection or breakage
    final safeSpeech = rawSpeech.replaceAll("'", "\\'");
    
    String prompt = "You are an autocorrect tool. Fix any typos or misheard Nigerian accents in this text. Output ONLY the fixed text, nothing else: '$safeSpeech'";
    
    try {
      // Accessing your API service
      String fixedText = await GroqApiService.askGroq(prompt, "llama3-8b-8192");
      
      // Infinite cleanup logic: removes quotes and extra whitespace
      return fixedText.replaceAll('"', '').trim(); 
    } catch (e) {
      // Return original text if the API fails so the app doesn't break
      return rawSpeech;
    }
  }
}
