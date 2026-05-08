import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/currency_manager.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class MysteryBox extends StatefulWidget {
  const MysteryBox({super.key});
  @override
  State<MysteryBox> createState() => _MysteryBoxState();
}

class _MysteryBoxState extends State<MysteryBox> {
  bool opened = false;

  void _open() {
    if (opened) return;
    setState(() => opened = true);
    int reward = Random().nextInt(50) + 10;
    context.read<CurrencyManager>().addSparks(reward);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _open,
      child: opened 
      ? Column(children: [const Icon(Icons.star, color: Colors.amber, size: 60), const Text("Claimed!")])
      : const Icon(Icons.inventory_2, color: Colors.purple, size: 60)
          .animate(onPlay: (c) => c.repeat())
          .shake(duration: 1000.ms),
    );
  }
}