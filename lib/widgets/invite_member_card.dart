import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class InviteMemberCard extends StatelessWidget {
  final String inviteCode;
  const InviteMemberCard({super.key, required this.inviteCode});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:[
            const Text("Invite a Family Member", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Share.share("Join my MindSpark Family Plan! Use code: $inviteCode at signup."),
              child: const Text("Share Invite Link"),
            )
          ],
        ),
      ),
    );
  }
}