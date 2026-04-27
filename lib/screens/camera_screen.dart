import 'package:flutter/material.dart';
import '../services/vision_engine.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String? res = await VisionEngine().snapAndSolve();
            if(context.mounted) showDialog(context: context, builder: (_) => AlertDialog(content: Text(res ?? "Failed")));
          },
          child: const Text("Snap & Solve"),
        ),
      ),
    );
  }
}