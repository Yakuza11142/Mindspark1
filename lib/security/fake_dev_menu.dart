import 'package:flutter/material.dart';

class FakeDevMenu extends StatelessWidget {
  const FakeDevMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // Silently logs their IP to Supabase as a threat while showing them a fake screen
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text("Developer Options Disabled in Production.", style: TextStyle(color: Colors.redAccent, fontFamily: 'monospace')),
      ),
    );
  }
}