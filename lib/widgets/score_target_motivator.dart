import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreTargetMotivator extends StatelessWidget {
  const ScoreTargetMotivator({super.key});

  Future<String> _getTarget() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('target_university') ?? "University";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getTarget(),
      builder: (ctx, snap) {
        return Container(
          padding: const EdgeInsets.all(10),
          color: Colors.white10,
          child: Row(
            children:[
              const Icon(Icons.flag, color: Colors.amber),
              const SizedBox(width: 10),
              Text("Target: ${snap.data} (Aim for 280+)", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}