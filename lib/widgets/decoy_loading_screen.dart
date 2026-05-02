import 'package:flutter/material.dart';

class DecoyLoadingScreen extends StatelessWidget {
  const DecoyLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            CircularProgressIndicator(color: Colors.grey),
            SizedBox(height: 20),
            Text("Synchronizing Neural Weights...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}