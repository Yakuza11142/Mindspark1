import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'age_gate_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _ctrl = PageController();
  int _page = 0;

  void _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);
    if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AgeGateScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _ctrl,
              onPageChanged: (i) => setState(() => _page = i),
              children: const [
                _Page(icon: Icons.auto_awesome, title: "Infinite Intelligence", desc: "Ask any question. Get instant 3D lessons."),
                _Page(icon: Icons.view_in_ar, title: "Holo-Deck", desc: "Project models into your room."),
                _Page(icon: Icons.emoji_events, title: "Crush Exams", desc: "Prepare for JAMB, WAEC, & SAT."),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _finish, 
            child: Text(_page == 2 ? "GET STARTED" : "SKIP")
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _Page extends StatelessWidget {
  final IconData icon;
  final String title, desc;
  const _Page({required this.icon, required this.title, required this.desc});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 100, color: Colors.cyan),
        const SizedBox(height: 30),
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}