import 'package:flutter/material.dart';
import '../services/sunk_cost_tracker.dart';

class SunkCostReminderCard extends StatelessWidget {
  const SunkCostReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: SunkCostTracker.getInvestmentSummary(),
      builder: (ctx, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: Colors.purple.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
          child: Row(
            children:[
              const Icon(Icons.psychology, color: Colors.purpleAccent, size: 40),
              const SizedBox(width: 15),
              Expanded(child: Text(snap.data!, style: const TextStyle(color: Colors.white70, fontSize: 14))),
            ],
          ),
        );
      },
    );
  }
}