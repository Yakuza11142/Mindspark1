import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Student";
  String? imagePath;
  int streak = 5;
  int totalXp = 1250;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('user_name') ?? "Student";
      imagePath = prefs.getString('user_avatar');
      // In real app, fetch streak/xp from CurrencyManager
    });
  }

  _pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_avatar', image.path);
      setState(() => imagePath = image.path);
    }
  }

  _editName() {
    TextEditingController ctrl = TextEditingController(text: name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Change Name"),
        content: TextField(controller: ctrl),
        actions: [
          TextButton(onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_name', ctrl.text);
            setState(() => name = ctrl.text);
            Navigator.pop(ctx);
          }, child: const Text("Save"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings), 
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // AVATAR
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white10,
                backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : null,
                child: imagePath == null ? const Icon(Icons.camera_alt, size: 40) : null,
              ),
            ),
            const SizedBox(height: 20),
            // NAME
            GestureDetector(
              onTap: _editName,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(width: 10),
                  const Icon(Icons.edit, color: Colors.grey, size: 20)
                ],
              ),
            ),
            const SizedBox(height: 40),
            // STATS ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statCard("🔥 Streak", "$streak Days", Colors.orange),
                _statCard("⚡ Total XP", "$totalXp", Colors.yellow),
                _statCard("🏆 League", "Gold", Colors.cyan),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5))
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 5),
          Text(value, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}