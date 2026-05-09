import 'package:flutter/material.dart';

class ParentalPinDialog extends StatefulWidget {
  final String correctPin;
  final int pinLength;

  // Pass the required PIN and length dynamically
  const ParentalPinDialog({
    super.key, 
    required this.correctPin, 
    this.pinLength = 4,
  });

  @override
  State<ParentalPinDialog> createState() => _ParentalPinDialogState();
}

class _ParentalPinDialogState extends State<ParentalPinDialog> {
  final TextEditingController _ctrl = TextEditingController();
  
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Parent Area"),
      content: TextField(
        controller: _ctrl, 
        keyboardType: TextInputType.number, 
        obscureText: true,
        maxLength: widget.pinLength, // Use dynamic length
        decoration: InputDecoration(
          labelText: "Enter ${widget.pinLength}-digit PIN",
          counterText: "", // Hides the character counter
        )
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), 
          child: const Text("Cancel")
        ),
        TextButton(
          onPressed: () {
            // Compare against the dynamic PIN passed to the widget
            if (_ctrl.text == widget.correctPin) {
              Navigator.pop(context, true); 
            } else {
              // Optional: Clear on wrong pin or show error
              _ctrl.clear();
            }
          }, 
          child: const Text("Unlock")
        )
      ],
    );
  }
}
final bool? unlocked = await showDialog<bool>(
  context: context,
  builder: (context) => const ParentalPinDialog(
    correctPin: "5566", // Your dynamic PIN
    pinLength: 4,
  ),
);

if (unlocked == true) {
  // Go to parent settings
}
