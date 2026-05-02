class RapidReviewPromptInjector {
  static String inject(String topic) {
    return "Explain '$topic'.[CRITICAL SYSTEM OVERRIDE: The user's exam is in 5 days. Output ONLY 3 bullet points containing the most frequently tested facts or formulas on this topic. Maximum 50 words. Do not use pleasantries.]";
  }
}