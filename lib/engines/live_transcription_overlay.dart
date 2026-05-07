import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class LiveTranscriptionOverlay extends StatefulWidget {
  const LiveTranscriptionOverlay({super.key});
  @override
  State<LiveTranscriptionOverlay> createState() => _LiveTranscriptionOverlayState();
}

class _LiveTranscriptionOverlayState extends State<LiveTranscriptionOverlay> {
  final SpeechToText _speech = SpeechToText();
  String words = "";

  @override
  void initState() {
    super.initState();
    _speech.initialize().then((_) {
      _speech.listen(onResult: (res) => setState(() => words = res.recognizedWords));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50, left: 20, right: 20,
      child: Text(words, style: const TextStyle(fontSize: 24, color: Colors.cyanAccent, backgroundColor: Colors.black54)),
    );
  }
}