import '../models/ai_persona.dart';

class AcademicPivotInfinite {
  static String executePivot(String userInput, AiPersona currentAh) {
    print("🛡️ Semantic Shield Activated: Intercepting inappropriate request.");

    if (currentAh.name == "Spark") {
      return "Boss, why you dey drop this kind scope? We get JAMB to crush. I've wiped that from my memory. Let's look at the structure of a cell instead.";
    } else if (currentAh.name == "Nexus") {
      return "I process highly complex academic data, and you attempt to input profanity? Unacceptable. We are moving on. Here is a breakdown of human anatomy.";
    } else {
      // Aria
      return "There is no need for that kind of language. I know studying is stressful, but let's stay focused. Tell me what subject you need help with.";
    }
  }
}