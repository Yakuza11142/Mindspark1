import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GuerrillaShareScreen extends StatelessWidget {
  const GuerrillaShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Zero-Data Share")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text("SHARE OFFLINE", style: TextStyle(color: Colors.cyanAccent, fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: QrImageView(data: "mindspark://offline-apk-transfer", size: 250),
            ),
            const SizedBox(height: 20),
            const Text("Tell your friend to scan this .", style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}