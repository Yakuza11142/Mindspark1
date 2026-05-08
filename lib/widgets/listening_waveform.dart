import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ListeningWaveform extends StatelessWidget {
  const ListeningWaveform({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 5, height: 20,
        color: Colors.redAccent,
      ).animate(onPlay: (c) => c.repeat(reverse: true))
       .scaleY(begin: 0.5, end: 1.5, duration: Duration(milliseconds: 200 * (i + 1)))),
    );
  }
}