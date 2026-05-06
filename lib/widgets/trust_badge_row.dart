import 'package:flutter/material.dart';

class TrustBadgeRow extends StatelessWidget {
  const TrustBadgeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const[
        Icon(Icons.lock, color: Colors.green, size: 16),
        Text(" 256-bit Encryption   ", style: TextStyle(color: Colors.grey, fontSize: 10)),
        Icon(Icons.verified_user, color: Colors.blue, size: 16),
        Text(" AI Verified", style: TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}