import 'package:flutter/material.dart';

class ExamDayRoutineScreen extends StatelessWidget {
  const ExamDayRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("D-Day Protocol")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const[
          ListTile(leading: Icon(Icons.print, color: Colors.cyan), title: Text("Print Slip (Color) - DONE?")),
          ListTile(leading: Icon(Icons.badge, color: Colors.cyan), title: Text("NIN Slip / ID Ready?")),
          ListTile(leading: Icon(Icons.directions_bus, color: Colors.cyan), title: Text("Transport Fare Sorted?")),
          ListTile(leading: Icon(Icons.watch_off, color: Colors.redAccent), title: Text("Leave Watch/Phone at Home.")),
        ],
      ),
    );
  }
}