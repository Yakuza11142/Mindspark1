import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/ad_manager.dart';

class AdRewardMultiplier extends StatelessWidget {
  final VoidCallback onDouble;
  const AdRewardMultiplier({super.key, required this.onDouble});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E293B),
      title: const Text("Double Your XP?", style: TextStyle(color: Colors.white)),
      content: const Text("Watch a short video to get 3x rewards.", style: TextStyle(color: Colors.white70)),
      actions:[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("No thanks", style: TextStyle(color: Colors.grey))),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent),
          onPressed: () {
            // Fault-Tolerant Ad Execution
            context.read<AdManager>().showRewarded(() {
              onDouble();
              Navigator.pop(context);
            });
          }, 
          child: const Text("WATCH", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
        )
      ],
    );
  }
}