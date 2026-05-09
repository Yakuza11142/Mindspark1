import 'package:flutter/material.dart';
import 'flashcard_game.dart';

class GameHubScreen extends StatelessWidget {
  final String topic;
  const GameHubScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Game Reactor")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Choose Game Mode", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.flip),
              label: const Text("Flashcards"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FlashcardGame(topic: topic))),
            ),
            // Add more games here
          ],
        ),
      ),
    );
  }
}