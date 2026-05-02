import 'package:shared_preferences/shared_preferences.dart';

class PositiveAffirmationGen {
  static Future<String> getAffirmation() async {
    final prefs = await SharedPreferences.getInstance();
    int score = prefs.getInt('highest_mock_score') ?? 0;
    
    if (score > 60) {
      return "You have already proven you can score $score%. You have done the work. Now, just execute.";
    }
    return "Every master was once a beginner. Consistency is your weapon. Breathe.";
  }
}