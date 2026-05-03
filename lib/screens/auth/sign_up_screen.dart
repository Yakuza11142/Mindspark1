import 'package:flutter/material.dart';
import '../../services/auth/supabase_auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();

  void _register() async {
    await SupabaseAuthProvider().signUp(_emailCtrl.text, _passCtrl.text, _nameCtrl.text);
    // User gets routed automatically by AuthStateWrapper
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          TextField(controller: _nameCtrl, decoration: const InputDecoration(hintText: "Full Name")),
          TextField(controller: _emailCtrl, decoration: const InputDecoration(hintText: "Email")),
          TextField(controller: _passCtrl, obscureText: true, decoration: const InputDecoration(hintText: "Password")),
          ElevatedButton(onPressed: _register, child: const Text("CREATE ACCOUNT"))
        ],
      ),
    );
  }
}