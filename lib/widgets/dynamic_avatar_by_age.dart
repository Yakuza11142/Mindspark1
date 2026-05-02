import 'package:flutter/material.dart';

class DynamicAvatarByAge extends StatelessWidget {
  final String lifeStage;
  const DynamicAvatarByAge({super.key, required this.lifeStage});

  @override
  Widget build(BuildContext context) {
    IconData icon = Icons.person;
    if (lifeStage == "JUNIOR") icon = Icons.face; // Cute face
    if (lifeStage == "ADULT") icon = Icons.business_center; // Professional
    
    return CircleAvatar(backgroundColor: Colors.white10, child: Icon(icon, color: Colors.cyan));
  }
}