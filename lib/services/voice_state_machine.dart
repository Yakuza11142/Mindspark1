class VoiceStateMachine {
  // States: IDLE, LISTENING, THINKING, SPEAKING
  static String currentState = "IDLE";

  static void setState(String state) {
    currentState = state;
    print("🎙️ Voice State Changed: $currentState");
  }
  
  static bool canListen() => currentState == "IDLE" || currentState == "SPEAKING_FINISHED";
}