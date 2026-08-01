import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'dart:math';
import 'dart:async';
import '../services/currency_manager.dart';
import 'package:provider/provider.dart';

class SpinWheelScreen extends StatefulWidget {
  const SpinWheelScreen({super.key});
  @override
  State<SpinWheelScreen> createState() => _SpinWheelScreenState();
}

class _SpinWheelScreenState extends State<SpinWheelScreen> {
  final StreamController<int> _ctrl = StreamController<int>.broadcast();
  
  // FIX: Created a fully allocated array containing exactly 7 elements
  late final List<int> rewards;
  
  bool _isSpinning = false;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _generateRandomRewards();
  }

  // Generates 7 completely dynamic random integer values for the wheel segments
  void _generateRandomRewards() {
    final random = Random();
    // Generates values like 5, 15, 25, etc., up to 100 max
    rewards = List.generate(7, (_) => (random.nextInt(20) + 1) * 5);
  }

  @override
  void dispose() {
    _ctrl.close();
    super.dispose();
  }

  void _spinWheel() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
      _selectedIndex = Fortune.randomInt(0, rewards.length);
    });

    _ctrl.add(_selectedIndex!);
  }

  void _onSpinComplete() {
    if (_selectedIndex == null || !mounted) return;

    final earnedReward = rewards[_selectedIndex!];
    context.read<CurrencyManager>().addSparks(earnedReward);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Claimed $earnedReward ⚡ Sparks!"),
        duration: const Duration(seconds: 2),
      ),
    );

    setState(() {
      _isSpinning = false;
    });
  }

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
                animateFirst: false,
                items: rewards
                    .map((e) => FortuneItem(
                          child: Text(
                            "$e ⚡", 
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
                onAnimationEnd: _onSpinComplete,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isSpinning ? null : _spinWheel,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(_isSpinning ? "SPINNING..." : "SPIN"),
            )
          ],
        ),
      ),
    );
  }
}
