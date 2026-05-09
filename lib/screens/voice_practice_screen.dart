import 'package:flutter/material.dart';
import '../engines/pronunciation_engine.dart';

class VoicePracticeScreen extends StatefulWidget {
  final String practiceText;
  final int passingScore;

  const VoicePracticeScreen({
    super.key, 
    required this.practiceText, // Pass your text here
    this.passingScore = 80,     // Customizable threshold
  });

  @override
  State<VoicePracticeScreen> createState() => _VoicePracticeScreenState();
}

class _VoicePracticeScreenState extends State<VoicePracticeScreen> {
  final PronunciationEngine _engine = PronunciationEngine();
  int? _currentScore;
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice Practice")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Read this aloud:", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Text(
                widget.practiceText, // Uses dynamic text
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: _isRecording ? Colors.red : null,
                ),
                icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                label: Text(_isRecording ? "Stop" : "Record"),
                onPressed: () async {
                  setState(() => _isRecording = true);
                  
                  // Score is calculated against the dynamic practiceText
                  final s = await _engine.scoreSpeech(widget.practiceText);
                  
                  setState(() {
                    _currentScore = s;
                    _isRecording = false;
                  });
                },
              ),

              if (_currentScore != null) ...[
                const SizedBox(height: 30),
                Text(
                  "Score: $_currentScore%",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    // Colors change based on the dynamic passingScore
                    color: _currentScore! >= widget.passingScore ? Colors.green : Colors.orange,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
