import 'package:flutter/material.dart';
import '../../services/auth/magic_link_auth.dart';
import '../../services/auth/google_one_tap.dart';

class MagicLoginScreen extends StatefulWidget {
  const MagicLoginScreen({super.key});
  @override
  State<MagicLoginScreen> createState() => _MagicLoginScreenState();
}

class _MagicLoginScreenState extends State<MagicLoginScreen> {
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  bool _linkSent = false;

  void _sendLink() async {
    setState(() => _loading = true);
    bool success = await MagicLinkAuth.sendMagicLink(_emailCtrl.text.trim());
    setState(() {
      _loading = false;
      _linkSent = success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.bolt, size: 80, color: Colors.cyanAccent),
            const SizedBox(height: 20),
            const Text("Enter MindSpark", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            
            if (_linkSent)
              const Text("Check your email! Click the magic link to enter.", style: TextStyle(color: Colors.greenAccent, fontSize: 18), textAlign: TextAlign.center)
            else ...[
              TextField(
                controller: _emailCtrl, 
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(hintText: "Enter your email", filled: true, fillColor: Colors.white10, border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              _loading 
                ? const CircularProgressIndicator(color: Colors.cyanAccent) 
                : ElevatedButton(onPressed: _sendLink, style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)), child: const Text("SEND MAGIC LINK")),
              
              const SizedBox(height: 30),
              const Text("OR", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              
              ElevatedButton.icon(
                icon: const Icon(Icons.g_mobiledata, color: Colors.black, size: 30),
                label: const Text("Continue with Google", style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
                onPressed: GoogleOneTap.signIn,
              )
            ]
          ],
        ),
      ),
    );
  }
}