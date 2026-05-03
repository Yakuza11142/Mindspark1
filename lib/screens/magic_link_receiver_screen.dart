import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main_layout_screen.dart';

class MagicLinkReceiverScreen extends StatefulWidget {
  const MagicLinkReceiverScreen({super.key});
  @override
  State<MagicLinkReceiverScreen> createState() => _MagicLinkReceiverScreenState();
}

class _MagicLinkReceiverScreenState extends State<MagicLinkReceiverScreen> {
  @override
  void initState() {
    super.initState();
    _handleIncomingLink();
  }

  void _handleIncomingLink() {
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn && mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayoutScreen()));
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
          children:[
            Icon(Icons.lock_open, color: Colors.greenAccent, size: 60),
            SizedBox(height: 20),
            Text("Authenticating Secure Link...", style: TextStyle(color: Colors.white)),
            CircularProgressIndicator(color: Colors.cyanAccent),
          ],
        ),
      ),
    );
  }
}