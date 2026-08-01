import 'package:flutter/material.dart';
import '../services/db/leaderboard_repository.dart';

class RealLeaderboardScreen extends StatefulWidget {
  const RealLeaderboardScreen({super.key});

  @override
  State<RealLeaderboardScreen> createState() => _RealLeaderboardScreenState();
}

class _RealLeaderboardScreenState extends State<RealLeaderboardScreen> {
  late Future<List<Map<String, dynamic>>> _leaderboardFuture;

  @override
  void initState() {
    super.initState();
    // FIX: Cache the database future to prevent re-fetching data on UI rebuilds
    _leaderboardFuture = LeaderboardRepository.getGlobalTop10();
  }

  Color _getPodiumColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFFD700); // Gold
      case 1:
        return const Color(0xFFC0C0C0); // Silver
      case 2:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Fallback text colors adapting to the current global theme mode
    final defaultTextColor = isDark ? Colors.white : Colors.blackDE;

    return Scaffold(
      appBar: AppBar(title: const Text("Global Brain League 🌍")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _leaderboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text("Error loading leaderboard: ${snapshot.error}"));
          }

          final users = snapshot.data ?? [];
          if (users.isEmpty) {
            return const Center(child: Text("No data available."));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: users.length,
            itemBuilder: (ctx, i) {
              final user = users[i];
              final isPro = user['is_pro'] ?? false;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getPodiumColor(i),
                  child: Text(
                    "#${i + 1}",
                    style: const TextStyle(
                      color: Colors.blackDE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  user['name'] ?? 'Unknown User',
                  style: TextStyle(
                    color: isPro ? Colors.cyan : defaultTextColor,
                    fontWeight: isPro ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: Text(
                  "${user['total_xp'] ?? 0} XP",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
