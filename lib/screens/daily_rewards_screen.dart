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
    _synchronizeStreakState();
  }

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
          claimAvailable = false; 
        } else if (differenceInDays > 1) {
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

  Future<void> _claimReward() async {
    if (!_canClaimToday || _isLoading) return;

    setState(() => _isLoading = true);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final DateTime now = DateTime.now().toUtc();
      final int nextStreakIndex = (_currentStreakIndex + 1) > 7 ? 1 : (_currentStreakIndex + 1);

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
        title: const Text("Daily Rewards", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              // FIX: Replaced explicit scrolling ListView with an auto-scaling multi-row layout grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Clean 4x2 matrix arrangement balances layout shapes natively
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.9, 
                ),
                itemCount: 7,
                itemBuilder: (context, index) {
                  final bool isClaimed = index < _currentStreakIndex;
                  final bool isToday = index == _currentStreakIndex && _canClaimToday;

                  Color cardColor = const Color(0xFF1E293B);
                  Color borderOutlineColor = Colors.transparent;
                  Color contentColor = Colors.white30;

                  if (isClaimed) {
                    cardColor = Colors.emerald.withOpacity(0.15);
                    borderOutlineColor = Colors.emerald;
                    contentColor = Colors.emerald;
                  } else if (isToday) {
                    cardColor = Colors.cyanAccent.withOpacity(0.2);
                    borderOutlineColor = Colors.cyanAccent;
                    contentColor = Colors.cyanAccent;
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderOutlineColor, width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Day ${index + 1}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isToday || isClaimed ? Colors.white : Colors.white60,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          isClaimed ? Icons.check_circle : Icons.workspace_premium,
                          color: contentColor,
                          size: 24,
                        ),
                      ],
                    ),
                  );
                },
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
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
