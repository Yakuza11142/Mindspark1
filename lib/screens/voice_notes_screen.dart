import 'package:flutter/material.dart';
import '../services/sound_recorder.dart';

class VoiceNotesScreen extends StatefulWidget {
  const VoiceNotesScreen({super.key});
  @override
  State<VoiceNotesScreen> createState() => _VoiceNotesScreenState();
}

class _VoiceNotesScreenState extends State<VoiceNotesScreen> {
  final SoundRecorder _rec = SoundRecorder();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onLongPress: _rec.start,
          onLongPressUp: _rec.stop,
          child: const CircleAvatar(radius: 50, child: Icon(Icons.mic, size: 40)),
        ),
      ),
    );
  }
}