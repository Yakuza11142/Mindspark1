import 'package:flutter/material.dart';

class DynamicGlobalCountdown extends StatelessWidget {
  final String examCode;
  final DateTime examDate; // Passed down from Supabase database

  const DynamicGlobalCountdown({
    super.key, 
    required this.examCode, 
    required this.examDate,
  });

  @override
  Widget build(BuildContext context) {
    // FIXED: Normalize both timestamps to local midnight times to calculate calendar days accurately
    final DateTime now = DateTime.now();
    final DateTime localExamDate = examDate.toLocal();
    
    final DateTime targetMidnight = DateTime(localExamDate.year, localExamDate.month, localExamDate.day);
    final DateTime currentMidnight = DateTime(now.year, now.month, now.day);
    
    final int daysLeft = targetMidnight.difference(currentMidnight).inDays;

    if (daysLeft < 0) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900], 
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "${examCode.toUpperCase()} EXAM IN: $daysLeft DAYS", 
        textAlign: TextAlign.center, 
        style: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold, 
          letterSpacing: 2,
        ),
      ),
    );
  }
}
