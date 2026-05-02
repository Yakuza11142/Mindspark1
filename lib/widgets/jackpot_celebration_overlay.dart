import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart'; // Ensure confetti is in pubspec

class JackpotCelebrationOverlay extends StatefulWidget {
  final int sparksWon;
  const JackpotCelebrationOverlay({super.key, required this.sparksWon});

  @override
  State<JackpotCelebrationOverlay> createState() => _JackpotCelebrationOverlayState();
}

class _JackpotCelebrationOverlayState extends State<JackpotCelebrationOverlay> {
  final ConfettiController _confetti = ConfettiController(duration: const Duration(seconds: 3));

  @override
  void initState() {
    super.initState();
    _confetti.play();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children:[
        ConfettiWidget(
          confettiController: _confetti,
          blastDirectionality: BlastDirectionality.explosive,
          colors: const[Colors.amber, Colors.orange, Colors.yellow],
        ),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber, width: 4)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              const Text("MEGA JACKPOT! 🎰", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.amber, decoration: TextDecoration.none)),
              const SizedBox(height: 20),
              Text("+${widget.sparksWon} ⚡", style: const TextStyle(fontSize: 60, color: Colors.cyanAccent, fontWeight: FontWeight.w900, decoration: TextDecoration.none)),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: const Text("CLAIM", style: TextStyle(color: Colors.black)))
            ],
          ),
        ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
      ],
    );
  }
}