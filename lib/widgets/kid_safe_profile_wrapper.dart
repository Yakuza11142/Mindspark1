import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KidSafeProfileWrapper extends StatelessWidget {
  final Widget adultFeatures;
  const KidSafeProfileWrapper({super.key, required this.adultFeatures});

  Future<bool> _isKid() async {
    final prefs = await SharedPreferences.getInstance();
    int birthYear = prefs.getInt('user_dob_year') ?? 2010;
    return (DateTime.now().year - birthYear) < 13;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isKid(),
      builder: (ctx, snap) {
        if (snap.data == true) {
          // Kid Mode: Hide social sharing and email updates
          return const Card(
            color: Colors.blueGrey,
            child: Padding(padding: EdgeInsets.all(10), child: Text("Junior Account: Social Features Disabled for Privacy 🛡️", style: TextStyle(color: Colors.white, fontSize: 12))),
          );
        }
        return adultFeatures; // Show normally to 13+
      },
    );
  }
}