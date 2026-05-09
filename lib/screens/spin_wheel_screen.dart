import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:async';
import '../services/currency_manager.dart';
import 'package:provider/provider.dart';

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({super.key});
  @override
  State<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  final StreamController<int> _ctrl = StreamController<int>();
  final List<int> rewards = [10, 20, 50, 100, 0, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Spin")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: FortuneWheel(
                selected: _ctrl.stream,
                items: rewards.map((e) => FortuneItem(child: Text("$e ⚡"))).toList(),
                onAnimationEnd: () {
                  // Grant Reward Logic
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reward Claimed!")));
                },
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                int index = Fortune.randomInt(0, rewards.length);
                _ctrl.add(index);
                context.read<CurrencyManager>().addSparks(rewards[index]);
              },
              child: const Text("SPIN"),
            )
          ],
        ),
      ),
    );
  }
}