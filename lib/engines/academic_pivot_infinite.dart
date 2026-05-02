import '../models/ai_persona.dart';

class AcademicPivotInfinite {
  static String executePivot(String userInput, AiPersona currentAh) {
    // Standard Flutter debug print
    print("🛡️ Semantic Shield Activated: Intercepting inappropriate request.");

    // Logic restricted only to Spark, speaking standard English
    if (currentAh.name == "Spark") {
      return "I've intercepted an inappropriate request. Let's stay focused on our academic goals. We have a lot to cover to ensure you're fully prepared for your exams. Let's get back to the lesson.";
    }

    // Standard fallback for any other persona
    return "Let's keep our focus on your studies. What subject should we review next?";
  }
}