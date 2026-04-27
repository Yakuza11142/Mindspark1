import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../engines/game_engine.dart';

class FlashcardGame extends StatefulWidget {
  final String topic;
  const FlashcardGame({super.key, required this.topic});
  @override
  State<FlashcardGame> createState() => _FlashcardGameState();
}

class _FlashcardGameState extends State<FlashcardGame> {
  List<Map<String, String>> cards = [];
  bool loading = true;
  bool showBack = false;
  int index = 0;

  @override
  void initState() {
    super.initState();
    GameEngine().generateFlashcards(widget.topic).then((c) {
      setState(() { cards = c; loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    
    return Scaffold(
      appBar: AppBar(title: Text("Flashcards: ${widget.topic}")),
      body: GestureDetector(
        onTap: () => setState(() => showBack = !showBack),
        child: Center(
          child: Container(
            width: 300, height: 400,
            decoration: BoxDecoration(
              color: showBack ? Colors.blueAccent : Colors.amber,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.white24, blurRadius: 20)]
            ),
            alignment: Alignment.center,
            child: Text(
              showBack ? cards[index]['back']! : cards[index]['front']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ).animate(target: showBack ? 1 : 0).flip(duration: 500.ms),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (index < cards.length - 1) setState(() { index++; showBack = false; });
          else Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}