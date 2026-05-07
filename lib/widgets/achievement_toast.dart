import 'package:flutter/material.dart';

class AchievementToast extends StatelessWidget {
  final String title;
  const AchievementToast({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:[
              const Icon(Icons.military_tech, color: Colors.black),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}