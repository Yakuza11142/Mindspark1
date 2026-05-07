import 'package:flutter/material.dart';

class EmptyLibraryState extends StatelessWidget {
  const EmptyLibraryState({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const[
          Icon(Icons.auto_stories, size: 80, color: Colors.white24),
          SizedBox(height: 20),
          Text("Your Library is Empty", style: TextStyle(fontSize: 20, color: Colors.white54)),
          Text("Save lessons to read them offline.", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}