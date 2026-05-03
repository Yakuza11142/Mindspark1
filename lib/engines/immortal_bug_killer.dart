import 'package:flutter/material.dart';

class ImmortalBugKiller extends StatelessWidget {
  final Widget child;
  const ImmortalBugKiller({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Container(
        color: const Color(0xFF0A0A0A),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            Icon(Icons.auto_awesome, color: Colors.cyanAccent, size: 50),
            SizedBox(height: 10),
            Text("Auto-Healing Matrix...", style: TextStyle(color: Colors.cyanAccent, fontSize: 12, decoration: TextDecoration.none)),
          ],
        ),
      );
    };
    return child;
  }
}