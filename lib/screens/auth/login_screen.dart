import 'package:flutter/material.dart';
import '../../services/auth/supabase_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  void _login() async {
    setState(() => _loading = true);
    try {
      await SupabaseAuthProvider().signIn(_emailCtrl.text.trim(), _passCtrl.text.trim());
      // AuthStateWrapper will automatically handle navigation
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
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
            const Text("MindSpark Elite", style: TextStyle(fontSize: 30, color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            TextField(controller: _emailCtrl, decoration: const InputDecoration(hintText: "Email", filled: true, fillColor: Colors.white10)),
            const SizedBox(height: 20),
            TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(hintText: "Password", filled: true, fillColor: Colors.white10)),
            const SizedBox(height: 30),
            _loading 
              ? const CircularProgressIndicator() 
              : ElevatedButton(onPressed: _login, child: const Text("LOGIN")),
          ],
        ),
      ),
    );
  }
}