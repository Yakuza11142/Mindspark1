import 'package:flutter/material.dart';

class ForceSleepOverlay extends StatelessWidget {
  const ForceSleepOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Icon(Icons.bedtime, size: 100, color: Colors.purpleAccent),
            SizedBox(height: 20),
            Text("BRAIN CAPACITY REACHED", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, decoration: TextDecoration.none)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("You have studied enough for today. Go to sleep. Your brain needs rest to encode these memories.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 16, decoration: TextDecoration.none)),
            ),
          ],
        ),
      ),
    );
  }
}