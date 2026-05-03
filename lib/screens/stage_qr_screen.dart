import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StageQrScreen extends StatelessWidget {
  const StageQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F), // Royal Navy Blue (Pageant Colors)
      appBar: AppBar(
        title: const Text("SCAN TO DOWNLOAD", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text(
              "MINDSPARK ELITE", 
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)
            ).animate().shimmer(duration: 2000.ms, color: Colors.cyanAccent),
            
            const SizedBox(height: 10),
            const Text("The Future of African Education", style: TextStyle(color: Colors.cyanAccent, fontSize: 18)),
            const SizedBox(height: 40),

            // THE QR CODE WIDGET
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow:[
                  BoxShadow(color: Colors.cyanAccent.withOpacity(0.5), blurRadius: 30, spreadRadius: 10)
                ]
              ),
              child: QrImageView(
                data: "https://mindspark.app/download", // Change this to your actual Play Store/Amazon link later
                version: QrVersions.auto,
                size: 250.0,
                backgroundColor: Colors.white,
                eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
                dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.black),
              ),
            ).animate().scaleXY(begin: 0.8, end: 1.0, duration: 500.ms, curve: Curves.easeOutBack),

            const SizedBox(height: 40),
            const Text("Point your camera at the screen.", style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 10),
            const Text("Use Promo Code 'HERO2026' for 500 Sparks ⚡", style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}