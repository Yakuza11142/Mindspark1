import 'package:flutter/material.dart';
import '../security/ceo_hardware_lock.dart';
// import '../admin/ceo_dashboard.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int _secretTapCount = 0;

  void _triggerVaultOrDecoy(BuildContext context) async {
    _secretTapCount++;
    if (_secretTapCount >= 5) {
      _secretTapCount = 0; // Reset
      
      bool isMyPhone = await CeoHardwareLock.verifyCeoDevice();
      if (isMyPhone) {
        // CEO RECOGNIZED. ENTER THE VAULT.
        // Navigator.push(context, MaterialPageRoute(builder: (_) => const CeoDashboard()));
      } else {
        // HACKER/STUDENT RECOGNIZED. SHOW DECOY.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🎉 You found a secret Easter Egg! Keep studying!"), 
            backgroundColor: Colors.purple
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: GestureDetector(
          onTap: () => _triggerVaultOrDecoy(context),
          child: const CircleAvatar(radius: 60, backgroundColor: Colors.cyanAccent, child: Icon(Icons.person, size: 60, color: Colors.black)),
        ),
      ),
    );
  }
}