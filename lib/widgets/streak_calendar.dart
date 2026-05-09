import 'package:flutter/material.dart';

class StreakCalendar extends StatelessWidget {
  const StreakCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: ["M", "T", "W", "T", "F", "S", "S"].map((day) {
          bool active = day == "M" || day == "T"; // Mock data
          return Column(
            children: [
              Text(day, style: const TextStyle(color: Colors.white54)),
              const SizedBox(height: 5),
              Icon(Icons.check_circle, color: active ? Colors.orange : Colors.grey, size: 20)
            ],
          );
        }).toList(),
      ),
    );
  }
}