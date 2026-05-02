import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricThumbprintSim extends StatelessWidget {
  final VoidCallback onSuccess;
  const BiometricThumbprintSim({super.key, required this.onSuccess});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          const Icon(Icons.fingerprint, size: 100, color: Colors.red),
          const SizedBox(height: 20),
          const Text("BIOMETRIC VERIFICATION REQUIRED", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              bool auth = await LocalAuthentication().authenticate(localizedReason: "Verify identity to enter CBT Hall");
              if (auth) onSuccess();
            }, 
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[900]),
            child: const Text("SCAN THUMB", style: TextStyle(color: Colors.white))
          )
        ],
      ),
    );
  }
}