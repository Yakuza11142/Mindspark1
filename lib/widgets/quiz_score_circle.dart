import 'package:flutter/material.dart';

class QuizScoreCircle extends StatelessWidget {
  final int score;
  const QuizScoreCircle({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    Color color = score > 5 ? Colors.green : Colors.red;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 100, width: 100,
          child: CircularProgressIndicator(value: score / 10, strokeWidth: 10, color: color, backgroundColor: Colors.white10),
        ),
        Text("$score/10", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color))
      ],
    );
  }
}