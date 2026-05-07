import 'package:flutter/material.dart';
import 'dart:math';

class MentalSwipeGame extends StatefulWidget {
  const MentalSwipeGame({super.key});
  @override
  State<MentalSwipeGame> createState() => _MentalSwipeGameState();
}

class _MentalSwipeGameState extends State<MentalSwipeGame> {
  String equation = "12 x 4 = 48";
  bool isTrue = true;
  int score = 0;

  void _generate() {
    int a = Random().nextInt(15);
    int b = Random().nextInt(15);
    isTrue = Random().nextBool();
    int ans = isTrue ? (a * b) : (a * b) + Random().nextInt(5) + 1;
    setState(() => equation = "$a x $b = $ans");
  }

  void _swipe(bool guess) {
    if (guess == isTrue) score++;
    _generate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mental Gym - Score: $score")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text("Is this True or False?", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Text(equation, style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                FloatingActionButton(backgroundColor: Colors.red, onPressed: () => _swipe(false), child: const Icon(Icons.close)),
                FloatingActionButton(backgroundColor: Colors.green, onPressed: () => _swipe(true), child: const Icon(Icons.check)),
              ],
            )
          ],
        ),
      ),
    );
  }
}