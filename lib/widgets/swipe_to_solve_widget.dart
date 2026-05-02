import 'package:flutter/material.dart';

class SwipeToSolveWidget extends StatelessWidget {
  final String question;
  const SwipeToSolveWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(question),
      background: Container(color: Colors.red, alignment: Alignment.centerLeft, padding: const EdgeInsets.all(20), child: const Icon(Icons.close, color: Colors.white, size: 40)),
      secondaryBackground: Container(color: Colors.green, alignment: Alignment.centerRight, padding: const EdgeInsets.all(20), child: const Icon(Icons.check, color: Colors.white, size: 40)),
      onDismissed: (direction) {
        bool answer = direction == DismissDirection.endToStart;
        print("User swiped: $answer");
      },
      child: Card(
        color: Colors.blueGrey[900],
        child: Container(height: 300, width: double.infinity, alignment: Alignment.center, child: Text(question, style: const TextStyle(fontSize: 24, color: Colors.white))),
      ),
    );
  }
}