import 'package:flutter/material.dart';

class UserAvatarBubble extends StatelessWidget {
  final bool isUser;
  const UserAvatarBubble({super.key, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: isUser ? Colors.cyan : Colors.purple,
      child: Icon(isUser ? Icons.person : Icons.auto_awesome, color: Colors.black, size: 16),
    );
  }
}