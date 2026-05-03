import 'package:flutter/material.dart';

class UserRetentionPopup extends StatelessWidget {
  const UserRetentionPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey[900],
      title: const Text("Don't give up now!"),
      content: const Text("Millions of students are competing for your spot. Do one more quick quiz."),
      actions:[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Rest", style: TextStyle(color: Colors.grey))),
        ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan), child: const Text("Keep Going 🚀", style: TextStyle(color: Colors.black)))
      ],
    );
  }
}