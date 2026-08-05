import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GlobalLeaderboardService {
  static final _supabase = Supabase.instance.client;

  /// Real-time Stream: No hardcoding, dynamic limit of 1000
  static Stream<List<Map<String, dynamic>>> getTopUsers() {
    return _supabase
        .from('users')
        .stream(primaryKey: ['id']) // Uses the 'id' cable to track changes
        .order('xp', ascending: false) // Highest XP first
        .limit(1000); // 1,000 user limit as requested
  }
}

// FIXED: Re-housed the floating widget cleanly into a valid, standalone component
class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: GlobalLeaderboardService.getTopUsers(), // FIXED: Changed '=' to constructor named parameters ':'
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error fetching records: ${snapshot.error}"));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final topUsers = snapshot.data!;
        if (topUsers.isEmpty) {
          return const Center(child: Text("No users registered on the board yet."));
        }

        return ListView.builder(
          itemCount: topUsers.length,
          itemBuilder: (BuildContext ctx, int index) {
            final user = topUsers[index];
            return ListTile(
              title: Text(user['username'] ?? 'Anonymous Genius'),
              subtitle: Text("XP: ${user['xp'] ?? 0}"),
              trailing: Text("#${index + 1}"), // The Rank
            );
          },
        );
      },
    );
  }
}
