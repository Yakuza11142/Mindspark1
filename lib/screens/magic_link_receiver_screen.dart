import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main_layout_screen.dart';

class MagicLinkReceiverScreen extends StatefulWidget {
  const MagicLinkReceiverScreen({super.key});
  @override
  State<MagicLinkReceiverScreen> createState() =>
      _MagicLinkReceiverScreenState();
}

class _MagicLinkReceiverScreenState extends State<MagicLinkReceiverScreen> {
  // Saved stream container instance reference to avoid memory leaks
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _handleIncomingLink();
  }

  @override
  void dispose() {
    // Closes and releases memory resources safely when screen closes
    _authSubscription?.cancel();
    super.dispose();
  }

  void _handleIncomingLink() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn && mounted) {
        // Shuts down listener immediately prior to pushing navigation pathing
        _authSubscription?.cancel();
        _authSubscription = null;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainLayoutScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_open, color: Colors.greenAccent, size: 60),
            SizedBox(height: 20),
            Text("Authenticating Secure Link...",
                style: TextStyle(color: Colors.white)),
            SizedBox(height: 20), // Added explicit spacing for tracking layout
            CircularProgressIndicator(color: Colors.cyanAccent),
          ],
        ),
      ),
    );
  }
}
