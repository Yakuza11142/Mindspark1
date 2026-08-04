import 'package:flutter/material.dart';

class ParentalPinDialog extends StatefulWidget {
  final String correctPin;
  final int pinLength;

  const ParentalPinDialog({
    super.key, 
    required this.correctPin, 
    this.pinLength = 4,
  });

  /// Static helper to trigger the dialog and await the dynamic PIN result
  static Future<bool> show(BuildContext context, {required String correctPin}) async {
    final bool? unlocked = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ParentalPinDialog(
        correctPin: correctPin,
        pinLength: 4,
      ),
    );
    return unlocked ?? false;
  }

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
        maxLength: widget.pinLength, 
        decoration: InputDecoration(
          labelText: "Enter ${widget.pinLength}-digit PIN",
          counterText: "", 
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), 
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_ctrl.text == widget.correctPin) {
              Navigator.pop(context, true); 
            } else {
              _ctrl.clear();
            }
          }, 
          child: const Text("Unlock"),
        ),
      ],
    );
  }
}
