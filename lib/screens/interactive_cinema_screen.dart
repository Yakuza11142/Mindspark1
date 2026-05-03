import 'package:flutter/material.dart';
import '../engines/heygen_interactive_stream.dart';

class InteractiveCinemaScreen extends StatefulWidget {
  final String characterName;
  const InteractiveCinemaScreen({super.key, required this.characterName});

  @override
  State<InteractiveCinemaScreen> createState() => _InteractiveCinemaScreenState();
}

class _InteractiveCinemaScreenState extends State<InteractiveCinemaScreen> {
  bool isListening = false;

  void _onMicHold() {
    setState(() => isListening = true);
    // Trigger Speech-To-Text
  }

  void _onMicRelease() async {
    setState(() => isListening = false);
    String userQuestion = "Explain Quantum Physics."; // Mock STT
    // 1. Groq generates text
    // 2. HeygenInteractiveStream.sendTextToAvatar(sessionId, groqText)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children:[
          // 1. The WebRTC Video Player showing the Avatar goes here
          const Center(child: Text("🎥 HeyGen Live Stream Active", style: TextStyle(color: Colors.cyan))),
          
          // 2. The Microphone Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: GestureDetector(
                onLongPress: _onMicHold,
                onLongPressUp: _onMicRelease,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: isListening ? Colors.red : Colors.cyanAccent,
                  child: const Icon(Icons.mic, size: 40, color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}