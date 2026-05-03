import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ViralDownloadScreen extends StatelessWidget {
  const ViralDownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text("JOIN THE REVOLUTION", style: TextStyle(color: Colors.amber, fontSize: 35, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: QrImageView(data: "https://mindspark.app/download", size: 300), // Link to your APK/Play Store
            ),
            const SizedBox(height: 20),
            const Text("Scan to Download MindSpark Elite", style: TextStyle(color: Colors.white, fontSize: 24)),
            const Text("Use code 'HERO2026' for 1000 Free Sparks", style: TextStyle(color: Colors.cyanAccent, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
// ... inside your Column children:
const Text(
  "DEMOCRACY DAY SPECIAL",
  style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold),
),
const SizedBox(height: 5),
const Text(
  "Use code 'MYHEROAWARD2026'",
  style: TextStyle(color: Colors.cyanAccent, fontSize: 20, fontWeight: FontWeight.bold),
),
const Text(
  "for 2000 Free Sparks!", // Increased from 1000 for the holiday
  style: TextStyle(color: Colors.cyanAccent, fontSize: 18),
),
const SizedBox(height: 20),
Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.white24),
    borderRadius: BorderRadius.circular(10),
  ),
  child: const Text(
    "ENDS TONIGHT @ 11:59 PM (JUNE 12)",
    style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: 1),
  ),
),
