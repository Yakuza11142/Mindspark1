import 'package:supabase_flutter/supabase_flutter.dart';

class GlobalLeaderboardService {
  static final _supabase = Supabase.instance.client;

  // Real-time Stream: No hardcoding, dynamic limit of 1000
  static Stream<List<Map<String, dynamic>>> getTopUsers() {
    return _supabase
        .from('users')
        .stream(primaryKey: ['id']) // Uses the 'id' cable to track changes
        .order('xp', ascending: false) // Highest XP first
        .limit(1000); // 1,000 user limit as requested
  }
}
StreamBuilder<List<Map<String, dynamic>>>(
  stream: GlobalLeaderboardService.getTopUsers(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    
    final topUsers = snapshot.data!;
    return ListView.builder(
      itemCount: topUsers.length,
      itemBuilder: (context, index) {
        final user = topUsers[index];
        return ListTile(
          title: Text(user['username'] ?? 'Anonymous Genius'),
          subtitle: Text("XP: ${user['xp']}"),
          trailing: Text("#${index + 1}"), // The Rank
        );
      },
    );
  },
)
