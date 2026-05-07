import 'package:flutter/material.dart';
import 'dart:async';

class ViralTicker extends StatefulWidget {
  const ViralTicker({super.key});
  @override
  State<ViralTicker> createState() => _ViralTickerState();
}

class _ViralTickerState extends State<ViralTicker> {
  String name = "Ahmed";
  
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 8), (t) {
      if (mounted) setState(() => name = ["Sarah", "Chioma", "David", "Emeka"][t.tick % 4]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.withOpacity(0.2),
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Text("🔥 $name just unlocked MindSpark Pro!", textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.greenAccent)),
    );
  }
}