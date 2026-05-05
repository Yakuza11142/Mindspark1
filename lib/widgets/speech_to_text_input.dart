import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextInput extends StatefulWidget {
  final TextEditingController controller;
  const SpeechToTextInput({super.key, required this.controller});

  @override
  State<SpeechToTextInput> createState() => _SpeechToTextInputState();
}

class _SpeechToTextInputState extends State<SpeechToTextInput> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          setState(() => widget.controller.text = val.recognizedWords);
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: _isListening ? Colors.red : Colors.cyan),
      onPressed: _listen,
    );
  }
}