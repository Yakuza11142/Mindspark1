import 'package:flutter/material.dart';

class ArTroubleshooterDialog extends StatelessWidget {
  const ArTroubleshooterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: const Text("Holo-Deck Unavailable", style: TextStyle(color: Colors.amber)),
      content: const Text("Your device doesn't support Google ARCore, or your camera permission is denied.\n\nYou can still interact with the 3D model on your screen!"),
      actions:[
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK, Got It", style: TextStyle(color: Colors.cyan)))
      ],
    );
  }
}