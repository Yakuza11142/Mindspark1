import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateRequiredScreen extends StatelessWidget {
  const UpdateRequiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.system_update, size: 80, color: Colors.amber),
            Text("Update Required", style: TextStyle(fontSize: 24)),
            Text("We added new AI brains. Update now."),
            // Add Button to launch store
          ],
        ),
      ),
    );
  }
}