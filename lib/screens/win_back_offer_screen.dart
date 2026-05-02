import 'package:flutter/material.dart';

class WinBackOfferScreen extends StatelessWidget {
  const WinBackOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Icon(Icons.local_fire_department, size: 100, color: Colors.amber),
              const SizedBox(height: 20),
              const Text("WE MISSED YOU.", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
              const Text("It's been 14 days. Your competition is studying. We want you back in the game.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 40),
              const Text("SPECIAL OFFER", style: TextStyle(color: Colors.amber, letterSpacing: 2)),
              const Text("Get MindSpark Pro at 50% Off.", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const Text("₦2,250 instead of ₦4,500", style: TextStyle(color: Colors.greenAccent)),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: const Text("CLAIM 50% OFF NOW", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))
            ],
          ),
        ),
      ),
    );
  }
}