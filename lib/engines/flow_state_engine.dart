class FlowStateEngine {
  static String injectMasteryPrompt(String basePrompt) {
    return "$basePrompt \n[SYSTEM INSTRUCTION: Do not rush the user. Break this concept down logically. The goal is deep comprehension and mastery. Use a calm, methodical tone. End by asking them if they understand the core principle.]";
  }
}