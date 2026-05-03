class TtsLanguageRouter {
  // Infinite scaling: Add any language code here without rewriting the logic
  static const Map<String, String> _voiceMatrix = {
    'fr': "french_voice_id",
    'hi': "indian_voice_id",
    'es': "spanish_voice_id",
    'en-US': "pNInz6obpgDQGcFmaJgB", // Adam (Male)
    'en-GB': "ErXwobaYiN019PkySvjV", // Antoni (Young Male)
    'yo': "yoruba_accent_id",        // Regional Nigerian Accent
    'ig': "igbo_accent_id",          // Regional Nigerian Accent
    'ha': "hausa_accent_id",         // Regional Nigerian Accent
  };

  static String getVoiceIdForLanguage(String langCode) {
    // 1. Precise Match: Look for the exact code (e.g., 'en-US')
    // 2. Partial Match: Look for the general language (e.g., 'fr')
    // 3. Global Fallback: Default to Rachel
    return _voiceMatrix[langCode] ?? 
           _voiceMatrix[langCode.split('-')[0]] ?? 
           "21m00Tcm4TlvDq8ikWAM"; 
  }
}
