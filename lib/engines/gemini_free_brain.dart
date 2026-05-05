import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets_fusion.dart';
import 'millisecond_updater.dart';

class GeminiFreeBrain {
  static Future<String> ask(String topic) async {
    final model = GenerativeModel(model: MillisecondUpdater.geminiModel, apiKey: SecretsFusion.geminiKey);
    final res = await model.generateContent([Content.text("Give a simple explanation of $topic. Upgrade to Pro for deep analysis.")]);
    return res.text ?? "Error";
  }
}