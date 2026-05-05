import 'package:flutter/material.dart';
import '../engines/unhackable_cert_ledger.dart';

class SecureVerificationPortal extends StatefulWidget {
  const SecureVerificationPortal({super.key});
  @override
  State<SecureVerificationPortal> createState() => _SecureVerificationPortalState();
}

class _SecureVerificationPortalState extends State<SecureVerificationPortal> {
  final TextEditingController _ctrl = TextEditingController();
  Map<String, dynamic>? result;
  String status = "";

  void _check() async {
    setState(() => status = "Checking Global Database...");
    var data = await UnhackableCertLedger.verify(_ctrl.text.trim());
    setState(() {
      result = data;
      status = data != null ? "AUTHENTIC CERTIFICATE" : "FORGERY DETECTED. NO RECORD FOUND.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MindSpark Verification")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:[
            const Icon(Icons.shield, size: 80, color: Colors.blueAccent),
            const SizedBox(height: 20),
            TextField(controller: _ctrl, decoration: const InputDecoration(hintText: "Enter Certificate ID")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _check, child: const Text("VERIFY")),
            const SizedBox(height: 40),
            Text(status, style: TextStyle(color: result != null ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 20)),
            if (result != null) ...[
              Text("Student: ${result!['student_name']}"),
              Text("Course: ${result!['course']}"),
              Text("Score: ${result!['score']}%"),
            ]
          ],
        ),
      ),
    );
  }
}