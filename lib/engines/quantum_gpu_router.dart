import '../config/secrets_fusion.dart';

class QuantumGpuRouter {
  static String getFastestEngine(int pingMs) {
    if (pingMs > 200) {
      print("OpenAI congested. Bypassing to Groq Llama-3 LPU.");
      return SecretsFusion.groqKey; // Use Groq
    }
    return SecretsFusion.openAI; // Use GPT-5.5
  }
}