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
  // Constant keys to prevent string hardcoding in logical functions
  static const String _dbKeyName = 'user_name';
  static const String _dbKeyAvatar = 'user_avatar';
  static const String _dbKeyStreak = 'user_streak';
  static const String _dbKeyXp = 'user_xp';
  static const String _dbKeyLeague = 'user_league';

  // State parameters initialized cleanly
  late String streakLabel;
  late String xpLabel;
  late String leagueLabel;
  late String dialogTitleText;
  late String dialogCancelText;
  late String dialogSaveText;

  String name = "User";
  String? imagePath;
  int streak = 0;
  int totalXp = 0;
  String league = "";

  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safely retrieve standard localizations
    dialogCancelText = MaterialLocalizations.of(context).cancelButtonLabel;
    dialogSaveText = MaterialLocalizations.of(context).saveButtonLabel;

    dialogTitleText = "Change Name";
    streakLabel = "🔥 Streak";
    xpLabel = "⚡ Total XP";
    leagueLabel = "🏆 League";
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      name = prefs.getString(_dbKeyName) ?? "User";
      imagePath = prefs.getString(_dbKeyAvatar);

      // Dynamic fallback metrics pulled out of preferences storage memory
      streak = prefs.getInt(_dbKeyStreak) ?? 5;
      totalXp = prefs.getInt(_dbKeyXp) ?? 1250;
      league = prefs.getString(_dbKeyLeague) ?? "Gold";

      _nameController.text = name;
    });
  }

  _pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_dbKeyAvatar, image.path);
      if (!mounted) return;
      setState(() => imagePath = image.path);
    }
  }

  _editName() {
    _nameController.text = name;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(dialogTitleText),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(dialogCancelText),
          ),
          TextButton(
            onPressed: () async {
              final newName = _nameController.text.trim();
              if (newName.isEmpty) return;

              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(_dbKeyName, newName);

              if (!mounted) return;
              setState(() => name = newName);
              Navigator.pop(ctx);
            },
            child: Text(dialogSaveText),
          )
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
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white10,
                  backgroundImage: imagePath != null && File(imagePath!).existsSync()
                      ? FileImage(File(imagePath!))
                      : null,
                  child: imagePath == null || !File(imagePath!).existsSync()
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _editName,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.edit, color: Colors.grey, size: 20)
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _statCard(streakLabel, "$streak Days", Colors.orange)),
                  const SizedBox(width: 8),
                  Expanded(child: _statCard(xpLabel, "$totalXp", Colors.amber)),
                  const SizedBox(width: 8),
                  Expanded(child: _statCard(leagueLabel, league, Colors.cyan)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label, 
            style: const TextStyle(color: Colors.white70, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color, 
              fontSize: 18, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
