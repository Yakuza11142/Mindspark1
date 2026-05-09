import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  Future<List<String>> _getBadges() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('badges') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Trophies")),
      body: FutureBuilder<List<String>>(
        future: _getBadges(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                const Icon(Icons.emoji_events, size: 50, color: Colors.amber),
                Text(snapshot.data![i], style: const TextStyle(color: Colors.white))
              ],
            ),
          );
        },
      ),
    );
  }
}