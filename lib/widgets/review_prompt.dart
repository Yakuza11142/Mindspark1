import 'package:flutter/material.dart';

class ReviewPrompt extends StatelessWidget {
  const ReviewPrompt({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white10,
      child: Column(
        children: [
          const Text("Enjoying MindSpark?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) => const Icon(Icons.star, color: Colors.amber)),
          )
        ],
      ),
    );
  }
}