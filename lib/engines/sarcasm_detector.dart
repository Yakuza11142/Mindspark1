class SarcasmDetector {
  static String preprocessPrompt(String input) {
    // Appends a hidden instruction to the LLM to handle teen sarcasm
    return "$input \n[SYSTEM NOTE: The user is a student. Detect and ignore sarcasm, focus on the academic question.]";
  }
}