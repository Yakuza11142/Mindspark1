import 'package:flutter/material.dart';

class CancelFrictionDialog extends StatelessWidget {
  final int currentStreak;
  final String targetExam;
  
  const CancelFrictionDialog({super.key, required this.currentStreak, required this.targetExam});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E293B),
      title: const Text("Wait! Are you sure?", style: TextStyle(color: Colors.redAccent)),
      content: Text("You have a $currentStreak-day streak. Your $targetExam exams are coming up. If you cancel Pro, you will lose access to AR, 3D Holo-Deck,Your progress and the Offline Syllabus. Your competitors will have the advantage.", style: const TextStyle(color: Colors.white70, height: 1.5)),
      actions:[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Keep Pro & Stay Smart", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold))),
        TextButton(onPressed: () {
          // Proceed to Google Play cancellation management
          Navigator.pop(context);
        }, child: const Text("I want to fail (Cancel)", style: TextStyle(color: Colors.grey, fontSize: 10))),
      ],
    );
  }
}