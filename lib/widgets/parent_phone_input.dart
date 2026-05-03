import 'package:flutter/material.dart';

class ParentPhoneInput extends StatelessWidget {
  const ParentPhoneInput({super.key});
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: "Parent's WhatsApp Number (Optional)",
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
      ),
    );
  }
}