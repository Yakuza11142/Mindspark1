import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class DailyRewardsScreen extends StatefulWidget {
  const DailyRewardsScreen({super.key});

  @override
  State<DailyRewardsScreen> createState() => _DailyRewardsScreenState();
}

class _DailyRewardsScreenState extends State<DailyRewardsScreen> {
  static const String _lastClaimKey = 'gamification_daily_reward_last_claim';
  static const String _currentStreakKey = 'gamification_daily_reward_streak_index';

  int _currentStreakIndex = 0;
  bool _canClaimToday = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Synchronize streak states on widget initializations [INDEX]
    _synchronizeStreakState();
  }

  /// Evaluates historical transaction logs to verify reward eligibility safely [INDEX]
  Future<void> _synchronizeStreakState() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      
      final String? lastClaimStr = prefs.getString(_lastReviewKey()); 
      final int storedStreak = prefs.getInt(_currentStreakKey) ?? 0;

      final DateTime now = DateTime.now().toUtc();
      bool claimAvailable = true;

      if (lastClaimStr != null) {
        final DateTime lastClaimDate = DateTime.parse(lastClaimStr).toUtc();
        final int differenceInDays = DateTime(now.year, now.month, now.day)
            .difference(DateTime(lastClaimDate.year, lastClaimDate.month, lastClaimDate.day))
            .inDays;

        if (differenceInDays == 0) {
          claimAvailable = false; // Already claimed calendar day [INDEX]
        } else if (differenceInDays > 1) {
          // Streak broken loop fallback: Reset progress if a full day was skipped [INDEX]
          developer.log("🏃 Gamification: User skipped a calendar day. Resetting streak parameters.");
          await prefs.setInt(_currentStreakKey, 0);
        }
      }

      if (!mounted) return;
      setState(() {
        _currentStreakIndex = claimAvailable && storedStreak >= 7 ? 0 : storedStreak;
        _canClaimToday = claimAvailable;
        _isLoading = false;
      });
    } catch (e, stack) {
      developer.log("❌ Gamification: Failure inside streak sync engine", error: e, stackTrace: stack);
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Commits a successful claim transaction atomically to block multi-tap exploits [INDEX]
  Future<void> _claimReward() async {
    if (!_canClaimToday || _isLoading) return;

    setState(() => _isLoading = true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final DateTime now = DateTime.now().toUtc();
      final int nextStreakIndex = (_currentStreakIndex + 1) > 7 ? 1 : (_currentStreakIndex + 1);

      // Group parallel async writes to protect preference store consistency [INDEX]
      await Future.wait([
        prefs.setString(_lastClaimKey, now.toIso8601String()),
        prefs.setInt(_currentStreakKey, nextStreakIndex),
      ]);

      developer.log("🎰 Gamification: Reward claimed securely. Index incremented to: $nextStreakIndex");
      
      if (!mounted) return;
      setState(() {
        _currentStreakIndex = nextStreakIndex;
        _canClaimToday = false;
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✨ Reward Claimed! Keep up the daily streak.")),
      );
    } catch (e) {
      developer.log("Error writing claim details: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _lastReviewKey() => _lastClaimKey; 

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0F172A),
        body: Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Daily Rewards", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Non-clipping horizontal linear distribution format matches standard product calendars [INDEX]
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final bool isClaimed = index < _currentStreakIndex;
                    final bool isToday = index == _currentStreakIndex && _canClaimToday;
                    
                    Color cardColor = const Color(0xFF334155);
                    if (isClaimed) cardColor = Colors.green;
                    if (isToday) cardColor = Colors.cyanAccent;

                    return Container(
                      width: 85,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Card(
                        color: cardColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Day ${index + 1}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isToday ? Colors.black : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Icon(
                              isClaimed ? Icons.check_circle : Icons.workspace_premium,
                              color: isToday ? Colors.black : (isClaimed ? Colors.white : Colors.white30),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _canClaimToday ? _claimReward : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 55),
                  backgroundColor: Colors.cyanAccent,
                  disabledBackgroundColor: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  _canClaimToday ? "CLAIM TODAY'S REWARD" : "ALREADY CLAIMED TODAY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _canClaimToday ? Colors.black : Colors.white30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
