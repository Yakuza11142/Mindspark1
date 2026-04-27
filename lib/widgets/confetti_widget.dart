import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart'; // Add to pubspec

class CelebrationWidget extends StatefulWidget {
  final Widget child;
  const CelebrationWidget({super.key, required this.child});

  @override
  State<CelebrationWidget> createState() => _CelebrationWidgetState();
}

class _CelebrationWidgetState extends State<CelebrationWidget> {
  late ConfettiController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = ConfettiController(duration: const Duration(seconds: 3));
    _ctrl.play();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _ctrl,
            blastDirectionality: BlastDirectionality.explosive,
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange],
          ),
        ),
      ],
    );
  }
}