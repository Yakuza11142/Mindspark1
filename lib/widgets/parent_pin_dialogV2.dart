import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentPinDialog {
  static Future<bool> verify(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String savedPin = prefs.getString('parent_pin') ?? "0000"; // Default pin
    
    String input = "";
    bool success = false;

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Enter Parent PIN"),
        content: TextField(
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 4,
          onChanged: (v) => input = v,
        ),
        actions:[
          TextButton(
            onPressed: () {
              if (input == savedPin) success = true;
              Navigator.pop(ctx);
            }, 
            child: const Text("Unlock")
          )
        ],
      ),
    );
    return success;
  }
}