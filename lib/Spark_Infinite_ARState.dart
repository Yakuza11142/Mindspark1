import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

class _SparkInfiniteARState extends State<SparkInfiniteAR> {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initVoiceAI();
  }

  void _initVoiceAI() async {
    _speechEnabled = await _speechToText.initialize();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5); // Adjust for a natural voice
  }

  // Spark "hears" a command and reacts
  void _startListening() async {
    await _speechToText.listen(onResult: (result) {
      String command = result.recognizedWords.toLowerCase();
      if (command.contains("grow")) {
        _sparkSpeak("Increasing height by two inches.");
        // Call your scaling logic here
      } else if (command.contains("who is this")) {
        _sparkSpeak("This is Alex, a top scorer in the class.");
      }
    });
  }

  // Spark "talks" back to the student
  Future _sparkSpeak(String text) async {
    await _flutterTts.speak(text);
  }
}
