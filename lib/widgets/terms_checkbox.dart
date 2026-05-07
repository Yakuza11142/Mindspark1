import 'package:flutter/material.dart';

class TermsCheckbox extends StatefulWidget {
  final Function(bool) onAgreed;
  const TermsCheckbox({super.key, required this.onAgreed});

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  bool agreed = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Checkbox(
          value: agreed,
          activeColor: Colors.cyan,
          onChanged: (v) {
            setState(() => agreed = v ?? false);
            widget.onAgreed(agreed);
          },
        ),
        const Expanded(child: Text("I agree to the Terms of Service and AI Privacy Policy.", style: TextStyle(color: Colors.white70, fontSize: 12))),
      ],
    );
  }
}