import 'dart:ui';
import 'package:flutter/material.dart';
import '../engines/certificate_designer.dart';

class CertificatePreviewScreen extends StatelessWidget {
  final String course;
  const CertificatePreviewScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("Claim Your Diploma"), backgroundColor: Colors.transparent),
      body: Column(
        children:[
          const SizedBox(height: 20),
          // Blurred Preview
          Stack(
            alignment: Alignment.center,
            children:[
              Container(
                height: 250, width: 350,
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.amber, width: 5)),
                child: const Center(child: Text("MINDSPARK DIPLOMA", style: TextStyle(color: Colors.black26, fontSize: 30, fontWeight: FontWeight.bold))),
              ),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(height: 250, width: 350, color: Colors.black.withOpacity(0.1)),
                ),
              ),
              const Icon(Icons.lock, size: 80, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 40),
          const Text("Official Verified Diploma", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Download your high-resolution, AI-verified PDF certificate. Perfect for university applications and portfolios.", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ),
          const Spacer(),
          ElevatedButton.icon(
            icon: const Icon(Icons.print, color: Colors.black),
            label: const Text("PRINT DIPLOMA (₦3,500)", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
            onPressed: () {
              // Trigger Payment Gateway (Google IAP) here
              // On Success:
              CertificateDesigner.generatePremiumDiploma("Mastermind", course, "March 24, 2026");
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}