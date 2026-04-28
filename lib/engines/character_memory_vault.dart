import 'package:shared_preferences/shared_preferences.dart';

class CharacterMemoryVault {
  static Future<String> getMemoryContext() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastStruggle = prefs.getString('last_struggled_topic');
    String userName = prefs.getString('user_name') ?? "my friend";
    
    if (lastStruggle != null) {
      return "Remember that $userName struggled with $lastStruggle yesterday. Ask them gently if they feel better about it today before starting the new lesson.";
    }
    return "Greet $userName warmly.";
  }
}