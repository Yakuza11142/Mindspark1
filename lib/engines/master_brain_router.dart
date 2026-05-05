import 'ai_fusion_engine.dart';
import 'gemini_free_brain.dart';
import '../services/pro_gatekeeper.dart';

class MasterBrainRouter {
  static Future<String> getLesson(String topic, bool isPro) async {
    if (ProGatekeeper.verify(isPro)) {
      return await AiFusionEngine.generateFusedLesson(topic);
    } else {
      return await GeminiFreeBrain.ask(topic);
    }
  }
}