import 'age_context_provider.dart';
import 'pedagogy_injector.dart';

class MasterBrainIntegrator {
  static Future<String> buildUltimatePrompt(String topic) async {
    String stage = await AgeContextProvider.getLifeStage();
    String basePrompt = "Teach $topic.";
    return PedagogyInjector.injectTeachingStyle(basePrompt, stage);
  }
}