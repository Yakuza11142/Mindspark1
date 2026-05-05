import 'package:supabase_database/supabase_database.dart';

class MillisecondUpdater {
  static String openAiModel = "gpt-5.5";
  static String groqModel = "llama3-70b-8192";
  static String geminiModel = "gemini-3.1-pro";

  static void startListening() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("ai_models");
    ref.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        var data = event.snapshot.value as Map<dynamic, dynamic>;
        openAiModel = data['openai'] ?? openAiModel;
        groqModel = data['groq'] ?? groqModel;
        geminiModel = data['gemini'] ?? geminiModel;
        print("⚡ AI Models Updated in 1ms: $openAiModel & $groqModel");
      }
    });
  }
}