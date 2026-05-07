import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SwipeHintOverlay extends StatelessWidget {
  const SwipeHintOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          const Icon(Icons.swipe_up, size: 80, color: Colors.white54)
            .animate(onPlay: (c) => c.repeat()).moveY(begin: 20, end: -20, duration: 1.seconds).fadeOut(),
          const Text("Swipe up for more", style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}