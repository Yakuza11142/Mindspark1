import '../engines/live_config_listener.dart';

class SystemPromptInjector {
  static String buildPrompt(String basePrompt) {
    return "${LiveConfigListener.liveSystemPrompt} \n\n Task: $basePrompt";
  }
}