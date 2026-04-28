import '../models/ai_persona.dart';

class PersonaMemoryInjector {
  static String inject(AiPersona persona, String basePrompt, String studentName) {
    if (persona.name == "Spark") {
      return "$basePrompt \n[SYSTEM: You are Spark. Call the user '$studentName' or 'Boss'. Be highly energetic. Use Nigerian Pidgin casually.]";
    } else if (persona.name == "Nexus") {
      return "$basePrompt \n[SYSTEM: You are Nexus. Do NOT use the user's name. Be cold, analytical, and strictly academic.]";
    } else {
      return "$basePrompt \n[SYSTEM: You are Aria. Be very gentle and supportive to $studentName. Tell a short story.]";
    }
  }
}