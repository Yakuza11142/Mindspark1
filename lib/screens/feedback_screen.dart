import 'package:flutter/material.dart';
import '../widgets/glass_container.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report Issue")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Tell us what went wrong. We read every message.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const GlassContainer(height: 150, child: TextField(maxLines: 5, decoration: InputDecoration(border: InputBorder.none, hintText: "Type here..."))),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to send to your Discord webhook or Firebase
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Feedback Sent!")));
              },
              child: const Text("Submit Report"),
            )
          ],
        ),
      ),
    );
  }
}