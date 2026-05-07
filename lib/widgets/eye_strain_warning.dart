import 'package:flutter/material.dart';

class EyeStrainWarning extends StatelessWidget {
  const EyeStrainWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Give your eyes a break! 👀"),
      content: const Text("You have been studying for 2 hours. Look at something 20 feet away for 20 seconds to prevent eye damage."),
      actions:[ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("I did it"))],
    );
  }
}