import 'package:flutter/material.dart';
import '../services/voice_command_listener.dart';

class VoiceControlScreen extends StatefulWidget {
  const VoiceControlScreen({super.key});
  @override
  State<VoiceControlScreen> createState() => _VoiceControlScreenState();
}

class _VoiceControlScreenState extends State<VoiceControlScreen> {
  String status = "Hold to Speak...";
  final VoiceCommandListener _voice = VoiceCommandListener();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.mic, size: 80, color: Colors.cyanAccent),
            const SizedBox(height: 20),
            Text(status, style: const TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() => status = "Listening (AI Context Active)...");
                _voice.listenForCommands((cmd) {
                  setState(() => status = "Understood: $cmd");
                  // Execute command
                });
              },
              child: const Text("ACTIVATE"),
            )
          ],
        ),
      ),
    );
  }
}