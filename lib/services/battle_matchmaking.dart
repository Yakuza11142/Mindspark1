import 'dart:async';
import 'dart:math';

// 1. Create a Model to prevent "hardcoded" Map keys
class Opponent {
  final String name;
  final int level;
  final String avatar;

  Opponent({required this.name, required this.level, required this.avatar});

  @override
  String toString() => 'Opponent(name: $name, level: $level, avatar: $avatar)';
}

class BattleMatchmaking {
  static final Random _random = Random();

  // Dynamic pool of data
  static const List<String> _names = ["Shadow", "Titan", "Nova", "Dragon", "Cipher"];
  static const List<String> _avatars = ["🛡️", "⚔️", "🔥", "🐲", "⚡"];

  /// Finds a random opponent within a range of the user's level.
  static Future<Opponent> findOpponent({int userLevel = 1}) async {
    try {
      // Simulate network latency (between 1-3 seconds)
      await Future.delayed(Duration(seconds: _random.nextInt(3) + 1));

      // DEBUG: Log the start of search
      print("Matchmaking: Searching for opponent near level $userLevel...");

      // logic: Randomly pick from lists and generate level +/- 3 of user
      final name = _names[_random.nextInt(_names.length)];
      final avatar = _avatars[_random.nextInt(_avatars.length)];
      
      // Ensure level is never less than 1
      final level = (userLevel + _random.nextInt(7) - 3).clamp(1, 99);

      final opponent = Opponent(name: name, level: level, avatar: avatar);

      // DEBUG: Log result
      print("Matchmaking: Found $opponent");
      
      return opponent;
    } catch (e) {
      // DEBUG: Catch network or logic errors
      print("Matchmaking Error: $e");
      rethrow;
    }
  }
}
