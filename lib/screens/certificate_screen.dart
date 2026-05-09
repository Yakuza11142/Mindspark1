import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../engines/certificate_generator.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  // Fetch certificates asynchronously from SharedPreferences
  Future<List<String>> _getCertificates() async {
    final prefs = await SharedPreferences.getInstance();
    // returns the list or an empty list if none exist
    return prefs.getStringList('my_certificates') ?? []; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Certificates")),
      body: FutureBuilder<List<String>>(
        future: _getCertificates(),
        builder: (context, snapshot) {
          // 1. Show loader while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // 2. Handle Errors
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final myCerts = snapshot.data ?? [];

          // 3. Handle Empty State
          if (myCerts.isEmpty) {
            return const Center(child: Text("No certificates found."));
          }

          // 4. Dynamic List (Infinite-ready)
          return ListView.builder(
            itemCount: myCerts.length,
            itemBuilder: (ctx, i) => ListTile(
              leading: const Icon(Icons.workspace_premium, color: Colors.amber, size: 40),
              title: Text(myCerts[i]),
              subtitle: const Text("Verified by MindSpark"),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () => CertificateGenerator.generate("Student Name", myCerts[i]),
              ),
            ),
          );
        },
      ),
    );
  }
}
