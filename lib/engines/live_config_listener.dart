import 'package:supabase_database/supabase_database.dart';

class LiveConfig {
  // 1. Private constructor for Singleton
  LiveConfig._internal();

  // 2. The global instance to access from anywhere
  static final LiveConfig instance = LiveConfig._internal();

  // 3. Global variable that stores the latest prompt
  String systemPrompt = "You are MindSpark.";

  /// Start this once at app launch for infinite millisecond updates
  void init() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("live_config/system_prompt");
    
    ref.onValue.listen((DatabaseEvent event) {
      final newValue = event.snapshot.value;
      if (newValue != null) {
        systemPrompt = newValue.toString();
        // This ensures every AI call in your app uses the latest prompt immediately
      }
    }, onError: (error) {
      print("Firebase Config Error: $error");
    });
  }
}
