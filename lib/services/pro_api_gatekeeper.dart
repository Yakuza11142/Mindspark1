class ProApiGatekeeper {
  static String getGroqModel(bool isPro) {
    // Pro users get the smartest Llama 3 model (70 Billion Parameters)
    if (isPro) return "llama3-70b-8192"; 
    // Free users get the lightning-fast smaller model (8 Billion Parameters)
    return "llama3-8b-8192"; 
  }
}