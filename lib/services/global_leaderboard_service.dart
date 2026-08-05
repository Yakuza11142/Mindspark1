import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GlobalLeaderboardService {
  static final _supabase = Supabase.instance.client;

  /// Fetches a snapshot of the leaderboard using index-optimized HTTP routing.
  /// This eliminates persistent socket overhead and keeps device battery usage low.
  static Future<List<Map<String, dynamic>>> getTopUsersSnapshot() async {
    try {
      final List<dynamic> response = await _supabase
          .from('users')
          .select('id, username, xp')
          .order('xp', descending: true) // Sorted efficiently server-side on your database index
          .limit(1000);

      return response.map((dynamic item) => Map<String, dynamic>.from(item as Map)).toList();
    } catch (exception) {
      // Re-throw to allow the FutureBuilder error loop state to catch it cleanly
      rethrow;
    }
  }
}

class LeaderboardView extends StatefulWidget {
  const LeaderboardView({super.key});

  @override
  State<LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  late Future<List<Map<String, dynamic>>> _leaderboardFuture;

  @override
  void initState() {
    super.initState();
    _refreshLeaderboard();
  }

  void _refreshLeaderboard() {
    // Guard ensures state parameters are never modified on an unlinked controller context
    if (!mounted) return;
    setState(() {
      _leaderboardFuture = GlobalLeaderboardService.getTopUsersSnapshot();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            _refreshLeaderboard();
            // Wait for the assigned future loop frame to complete safely before dropping animation spinners
            await _leaderboardFuture.catchError((_) => <Map<String, dynamic>>[]);
          },
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _leaderboardFuture,
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              // If the user closed the window mid-request, abort immediate layout loops immediately
              if (!mounted) return const SizedBox.shrink();

              if (snapshot.hasError) {
                return ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          "Error fetching records: ${snapshot.error}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final List<Map<String, dynamic>> topUsers = snapshot.data ?? [];

              if (topUsers.isEmpty) {
                return ListView(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text("No users registered on the board yet."),
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: topUsers.length,
                itemBuilder: (BuildContext ctx, int index) {
                  final Map<String, dynamic> user = topUsers[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: index == 0 
                          ? Colors.amber 
                          : (index == 1 ? Colors.grey : (index == 2 ? Colors.brown : Colors.blueGrey)),
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    title: Text(
                      user['username']?.toString() ?? 'Anonymous Genius',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      "XP: ${user['xp'] ?? 0}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: index < 3 
                        ? const Icon(Icons.emoji_events, color: Colors.amber, size: 20)
                        : const SizedBox.shrink(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
