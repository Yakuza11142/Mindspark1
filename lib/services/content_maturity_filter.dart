class ContentMaturityFilter {
  static String filterVisualPrompt(String prompt, String lifeStage) {
    if (lifeStage == "JUNIOR") {
      return "$prompt. Make it cartoonish, kid-friendly, colorful, and completely safe for children. No scary imagery.";
    }
    return "$prompt. Hyper-realistic, scientific, highly detailed.";
  }
}
class ReportToneEngine {
  static String getWhatsAppMessage(String name, int score, String stage) {
    // 1. Determine Performance Category
    String status = score >= 80 ? "EXCELLENT" : score >= 50 ? "STEADY" : "NEEDS_HELP";

    // 2. Junior Tone (Encouragement & Bonding)
    if (stage == "JUNIOR") {
      if (status == "EXCELLENT") {
        return "🌟 *MindSpark Bravo!* \n\n$name scored a massive $score% today! They are becoming a superstar. Reward them with 15 minutes of extra play time tonight! 🎮";
      }
      return "📚 *Keep Going!* \n\n$name completed their lessons today with $score%. Every bit of practice makes them smarter. Try reading one page of a book together tonight! 📖";
    }

    // 3. Senior Tone (JAMB/University Focus - Data Driven)
    if (status == "EXCELLENT") {
      return "🚀 *University Bound!* \n\n$name scored $score% in their JAMB Mock. This puts them in the *Top 5%* of candidates. Keep the momentum high! 🔥";
    } else if (status == "NEEDS_HELP") {
      return "⚠️ *MindSpark Alert:* \n\n$name scored $score% in their latest session. To stay on track for University admission, they need to review *Physics & Math* tonight. Check the app for weak points.";
    }
    
    return "📈 *Progress Report:* \n\n$name is consistent! Score: $score%. They are on the right path to their target exam. Encourage them to hit 80% tomorrow!";
  }
}
