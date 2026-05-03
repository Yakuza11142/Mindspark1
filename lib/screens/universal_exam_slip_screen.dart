import 'package:flutter/material.dart';
import 'dart:math';

class UniversalExamSlipScreen extends StatelessWidget {
  final String studentName;
  final String examName; // "SAT", "JAMB", "GCSE", "ICAN"
  final List<String> subjects;
  final String centerName;

  const UniversalExamSlipScreen({
    super.key, 
    required this.studentName, 
    required this.examName, 
    required this.subjects,
    this.centerName = "MindSpark Virtual Global Center"
  });

  @override
  Widget build(BuildContext context) {
    String regNum = "${examName.substring(0,2).toUpperCase()}2026${Random().nextInt(999999)}";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("$examName Mock Slip"), backgroundColor: Colors.blueGrey[900]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey, width: 2)),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Center(child: Text("$examName OFFICIAL MOCK EXAMINATION", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))),
              const Divider(color: Colors.black),
              Text("Registration No: $regNum", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              Text("Candidate: ${studentName.toUpperCase()}", style: const TextStyle(color: Colors.black)),
              Text("Center: $centerName", style: const TextStyle(color: Colors.black)),
              const SizedBox(height: 20),
              const Text("Registered Subjects:", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
              const SizedBox(height: 5),
              ...subjects.asMap().entries.map((e) => Text("${e.key + 1}. ${e.value}", style: const TextStyle(color: Colors.black87))),
              const Spacer(),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[900]),
                  onPressed: () => Navigator.pop(context), 
                  icon: const Icon(Icons.computer, color: Colors.white),
                  label: const Text("Enter Exam Hall", style: TextStyle(color: Colors.white))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}