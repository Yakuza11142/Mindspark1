import 'package:flutter/material.dart';
import 'glass_container.dart';

class TutorialDialog extends StatelessWidget {
  const TutorialDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassContainer(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.view_in_ar, size: 50, color: Colors.cyan),
            const Text("HOLO-DECK GUIDE", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text("1. Point at floor.\n2. Walk forward to ZOOM.\n3. Tap to place.", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("GOT IT"))
          ],
        ),
      ),
    );
  }
}