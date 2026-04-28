import 'package:flutter/material.dart';
import '../engines/ah_vulgarity_defense.dart';
import '../services/active_persona_manager.dart';
import 'package:provider/provider.dart';

class AhChatInterceptor {
  static Future<String?> processInput(BuildContext context, String userInput) async {
    final currentAh = context.read<ActivePersonaManager>().currentPersona;

    if (AhVulgarityDefense.containsVulgarity(userInput)) {
      print("🛡️ A.H. Defense Triggered: Insult neutralized.");
      // Return the human-like scolding message INSTANTLY (0 API Cost)
      return AhVulgarityDefense.getHumanResponse(userInput, currentAh);
    }
    
    return null; // Input is clean, proceed to Groq/OpenAI
  }
}