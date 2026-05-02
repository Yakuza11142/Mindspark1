class PedagogyInjector {
  static String injectTeachingStyle(String basePrompt, String lifeStage) {
    if (lifeStage == "JUNIOR") {
      return "$basePrompt \n[SYSTEM: The user is a child under 13. Use simple words, emojis, and fun analogies like superheroes or animals. Keep it very encouraging. Maximum 3 short paragraphs.]";
    } else if (lifeStage == "SCHOLAR") {
      return "$basePrompt \n[SYSTEM: The user is a high school teen preparing for JAMB/WAEC. Be a strict but motivating exam coach. Use bullet points and highlight formulas or key facts to memorize.]";
    } else {
      // ADULT
      return "$basePrompt \n[SYSTEM: The user is an adult or university student. Be highly professional, academic, and concise. Do not use emojis or childish analogies.]";
    }
  }
}