import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.bolt, size: 100, color: Colors.cyanAccent),
            const SizedBox(height: 20),
            const Text("MindSpark Cloud", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            const Text("Sync your Brain across devices.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            
            // GOOGLE BUTTON
            ElevatedButton.icon(
              icon: const Icon(Icons.login, color: Colors.black),
              label: const Text("Continue with Google", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)
              ),
              onPressed: () => AuthService().signInWithGoogle(),
            ),
            
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Logic for "Continue as Guest" (Uses Anonymous Auth)
              },
              child: const Text("Skip for now", style: TextStyle(color: Colors.white54)),
            )
          ],
        ),
      ),
    );
  }
}