import 'package:flutter/material.dart';
import 'dart:async';

class DeepFocusTimer extends StatefulWidget {
  const DeepFocusTimer({super.key});
  @override
  State<DeepFocusTimer> createState() => _DeepFocusTimerState();
}

class _DeepFocusTimerState extends State<DeepFocusTimer> {
  int secondsFocused = 0;
  late Timer t;

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => secondsFocused++));
  }

  @override
  void dispose() { t.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    int m = secondsFocused ~/ 60;
    int s = secondsFocused % 60;
    return Text(
      "Deep Focus: ${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}", 
      style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontFamily: 'monospace')
    );
  }
}