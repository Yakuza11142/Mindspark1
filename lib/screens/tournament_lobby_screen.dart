import 'package:flutter/material.dart';
import '../engines/tournament_engine.dart';

class TournamentLobbyScreen extends StatelessWidget {
  const TournamentLobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool active = TournamentEngine.isTournamentActive();
    return Scaffold(
      appBar: AppBar(title: const Text("MindSpark Tournaments 🏆")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Icon(Icons.emoji_events, size: 100, color: active ? Colors.amber : Colors.grey),
            const SizedBox(height: 20),
            Text(active ? TournamentEngine.getTournamentTheme() : "Next Tournament: Saturday", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: active ? () {} : null,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
              child: Text(active ? "ENTER ARENA (Entry: 100 ⚡)" : "ARENA CLOSED", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}