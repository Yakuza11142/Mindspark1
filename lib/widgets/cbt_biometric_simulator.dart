import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class CbtBiometricSimulator extends StatelessWidget {
  final VoidCallback onVerified;
  const CbtBiometricSimulator({super.key, required this.onVerified});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        const Text("CBT CENTER VERIFICATION", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 20),
        const Icon(Icons.fingerprint, size: 100, color: Colors.red),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final auth = LocalAuthentication();
            bool passed = await auth.authenticate(localizedReason: "Verify Thumbprint to enter Virtual Exam Hall");
            if (passed) onVerified();
          },
          child: const Text("PLACE THUMB ON SCANNER"),
        )
      ],
    );
  }
}