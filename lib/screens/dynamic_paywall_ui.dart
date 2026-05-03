import 'package:flutter/material.dart';

class DynamicPaywallUi extends StatelessWidget {
  final String countryCode;

  const DynamicPaywallUi({super.key, required this.countryCode});

  // 🌍 THE INFINITE CONFIGURATION MATRIX
  // Easily add any country here. The UI will auto-update.
  static const Map<String, Map<String, String>> _marketConfig = {
    'NG': {'price': '₦4,500', 'pitch': 'Crush JAMB & WAEC', 'cta': 'GET NIGERIA PRO'},
    'GB': {'price': '£9.99', 'pitch': 'Master GCSE & A-Levels', 'cta': 'UNLOCK UK ELITE'},
    'US': {'price': '\$9.99', 'pitch': 'Ace SAT & AP Exams', 'cta': 'GO GLOBAL PRO'},
    'IN': {'price': '₹499', 'pitch': 'Conquer JEE & NEET', 'cta': 'START LEARNING'},
  };

  @override
  Widget build(BuildContext context) {
    // Fallback to Global defaults if country is not in the list
    final config = _marketConfig[countryCode] ?? {
      'price': '\$9.99',
      'pitch': 'Master Your Exams',
      'cta': 'UPGRADE NOW'
    };

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // 💎 ELITE GRADIENT: Deep matrix feel
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF000000), Color(0xFF001A1A)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🌟 GLOWING ICON MOCKUP
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.diamond_outlined, color: Colors.cyanAccent, size: 100),
            ),
            const SizedBox(height: 30),
            
            const Text(
              "MINDSPARK ELITE",
              style: TextStyle(
                fontSize: 32, 
                color: Colors.white, 
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            
            Text(
              config['pitch']!.toUpperCase(),
              style: TextStyle(color: Colors.cyanAccent.withOpacity(0.7), fontSize: 16, letterSpacing: 1.5),
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Divider(color: Colors.white10),
            ),

            // 💰 THE CALL TO ACTION
            ElevatedButton(
              onPressed: () {}, // Link to In-App Purchase
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                elevation: 20,
              ),
              child: Text(
                "${config['cta']} - ${config['price']}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            
            const SizedBox(height: 20),
            const Text(
              "SECURE ENCRYPTED CHECKOUT",
              style: TextStyle(color: Colors.white24, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
