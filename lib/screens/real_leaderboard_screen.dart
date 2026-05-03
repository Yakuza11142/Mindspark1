import 'package:flutter/material.dart';
import '../services/db/leaderboard_repository.dart';

class RealLeaderboardScreen extends StatelessWidget {
  const RealLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Global Brain League 🌍")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: LeaderboardRepository.getGlobalTop10(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text("No data available."));

          var users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, i) => ListTile(
              leading: CircleAvatar(backgroundColor: i < 3 ? Colors.amber : Colors.grey, child: Text("#${i+1}")),
              title: Text(users[i]['name'], style: TextStyle(color: users[i]['is_pro'] ? Colors.cyanAccent : Colors.white)),
              trailing: Text("${users[i]['total_xp']} XP", style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}