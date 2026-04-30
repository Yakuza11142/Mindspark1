import 'package:flutter/material.dart';

class DrmViolationScreen extends StatelessWidget {
  const DrmViolationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Icon(Icons.gavel, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text("PIRACY DETECTED", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("This device has engaged in unauthorized extraction of premium assets. Your account and hardware ID have been permanently banned.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}