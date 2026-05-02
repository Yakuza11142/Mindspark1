import 'package:flutter/material.dart';
import '../engines/avatar_generator_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarCreationScreen extends StatefulWidget {
  const AvatarCreationScreen({super.key});
  @override
  State<AvatarCreationScreen> createState() => _AvatarCreationScreenState();
}

class _AvatarCreationScreenState extends State<AvatarCreationScreen> {
  final TextEditingController _ctrl = TextEditingController();
  String? avatarUrl;
  bool isGenerating = false;

  void _generate() async {
    setState(() => isGenerating = true);
    String? url = await AvatarGeneratorEngine.generateAvatar(_ctrl.text);
    
    if (url != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_avatar_url', url); // Save to phone
    }
    setState(() { avatarUrl = url; isGenerating = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("Create AI Avatar")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white10,
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child: isGenerating ? const CircularProgressIndicator(color: Colors.amber) : (avatarUrl == null ? const Icon(Icons.person, size: 80) : null),
            ),
            const SizedBox(height: 40),
            TextField(controller: _ctrl, decoration: const InputDecoration(hintText: "e.g., A smart Nigerian boy with neon glasses", filled: true)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _generate, child: const Text("Generate Profile Pic"))
          ],
        ),
      ),
    );
  }
}