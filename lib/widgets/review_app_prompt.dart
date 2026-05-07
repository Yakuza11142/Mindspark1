import 'package:flutter/material.dart';

class ReviewAppPrompt extends StatelessWidget {
  const ReviewAppPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enjoying MindSpark?"),
      content: const Text("If we helped you learn today, please give us 5 stars."),
      actions:[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Later")),
        ElevatedButton(onPressed: () { /* Trigger InAppReview */ }, child: const Text("Rate 5 Stars ⭐️"))
      ],
    );
  }
}