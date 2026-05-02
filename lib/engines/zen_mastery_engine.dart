class ZenMasteryEngine {
  static String injectZen(String prompt) {
    return "$prompt \n[SYSTEM INSTRUCTION: The user's exam is in 5 days. DO NOT USE URGENT OR STRESSFUL LANGUAGE. Be a calm, stoic, and highly reassuring mentor. Use phrases like 'You already know this' and 'Let's just review calmly'. Focus on clarity and deep understanding.]";
  }
}