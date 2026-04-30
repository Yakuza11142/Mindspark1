import 'package:flutter/material.dart';

class OfflineToastController {
  static void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange[900],
        content: const Row(
          children:[
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 10),
            Text("Offline Mode Active. Using local data.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      )
    );
  }
}