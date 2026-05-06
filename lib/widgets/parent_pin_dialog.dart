import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MindSparkSettings extends StatefulWidget {
  const MindSparkSettings({super.key});

  @override
  State<MindSparkSettings> createState() => _MindSparkSettingsState();
}

class _MindSparkSettingsState extends State<MindSparkSettings> {
  final TextEditingController _pinController = TextEditingController();
  String _currentPin = "0000";

  @override
  void initState() {
    super.initState();
    _loadPin();
  }

  Future<void> _loadPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentPin = prefs.getString('parent_pin') ?? "0000";
    });
  }

  // WRAPPER: This forces the user to enter a PIN before doing anything
  Future<void> _protectedAction(Function onAuthorized) async {
    String input = "";
    bool authorized = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF0F172A),
        title: const Text("Parental Authorization", style: TextStyle(color: Colors.white)),
        content: TextField(
          autofocus: true,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 4,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: "Enter 4-digit PIN", hintStyle: TextStyle(color: Colors.white54)),
          onChanged: (v) => input = v,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, input == _currentPin),
            child: const Text("Verify", style: TextStyle(color: Colors.cyanAccent)),
          )
        ],
      ),
    );

    if (authorized == true) {
      onAuthorized();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Access Denied: Incorrect PIN")),
      );
    }
  }

  Future<void> _changePin() async {
    // Logic to update the PIN in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('parent_pin', _pinController.text);
    setState(() => _currentPin = _pinController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("Elite Settings"), backgroundColor: Colors.transparent),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.cyanAccent),
            title: const Text("Change Parent PIN", style: TextStyle(color: Colors.white)),
            onTap: () => _protectedAction(() {
              // Show dialog to set NEW pin
              _showNewPinDialog();
            }),
          ),
          ListTile(
            leading: const Icon(Icons.child_care, color: Colors.cyanAccent),
            title: const Text("Edit Student Age", style: TextStyle(color: Colors.white)),
            onTap: () => _protectedAction(() {
              print("Age editing unlocked!"); // Add your age picker here
            }),
          ),
        ],
      ),
    );
  }

  void _showNewPinDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Set New PIN"),
        content: TextField(controller: _pinController, keyboardType: TextInputType.number, maxLength: 4),
        actions: [TextButton(onPressed: () { _changePin(); Navigator.pop(ctx); }, child: const Text("Save"))],
      ),
    );
  }
}
