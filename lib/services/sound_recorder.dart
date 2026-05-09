// Uses flutter_sound or similar package (Placeholder logic)
class SoundRecorder {
  bool isRecording = false;
  void start() { isRecording = true; print("Recording started"); }
  void stop() { isRecording = false; print("Recording stopped"); }
}