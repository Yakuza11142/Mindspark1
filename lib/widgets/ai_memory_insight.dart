import 'package:flutter/material.dart';

class InfiniteAiMemoryInsight extends StatefulWidget {
  const InfiniteAiMemoryInsight({super.key});

  @override
  State<InfiniteAiMemoryInsight> createState() => _InfiniteAiMemoryInsightState();
}

class _InfiniteAiMemoryInsightState extends State<InfiniteAiMemoryInsight> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    // Setting up an infinite 2-second pulse
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); 

    _opacity = Tween<double>(begin: 0.4, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple), 
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.psychology, color: Colors.purpleAccent, size: 16),
            SizedBox(width: 8),
            Text(
              "🧠 AI Context: Real-time Calculus Analysis active...", 
              style: TextStyle(color: Colors.purpleAccent, fontSize: 12, fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
    );
  }
}
