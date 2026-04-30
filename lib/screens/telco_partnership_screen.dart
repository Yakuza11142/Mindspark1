import 'package:flutter/material.dart';

class TelcoPartnershipScreen extends StatelessWidget {
  const TelcoPartnershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("Telco Partner Dashboard")),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text("MINDSPARK x MTN DATA USAGE", style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Total Users on Network: 450,210", style: TextStyle(color: Colors.white, fontSize: 18)),
            Text("Average Data per Lesson: 12KB (Ultra-Compressed)", style: TextStyle(color: Colors.cyan)),
            Text("Total Monthly Bandwidth: 1.2TB", style: TextStyle(color: Colors.amber)),
          ],
        ),
      ),
    );
  }
}