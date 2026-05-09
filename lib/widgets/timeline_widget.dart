import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final String year;
  final String event;
  final bool isLast;

  const TimelineItem({super.key, required this.year, required this.event, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const CircleAvatar(radius: 5, backgroundColor: Colors.cyanAccent),
            if (!isLast) Container(width: 2, height: 50, color: Colors.white24),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(year, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
              Text(event, style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }
}