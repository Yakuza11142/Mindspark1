import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicProfilePic extends StatelessWidget {
  final double radius;
  const DynamicProfilePic({super.key, this.radius = 20});

  Future<String?> _getUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_avatar_url');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getUrl(),
      builder: (ctx, snap) {
        if (snap.hasData && snap.data != null) {
          return CircleAvatar(radius: radius, backgroundImage: NetworkImage(snap.data!));
        }
        return CircleAvatar(radius: radius, backgroundColor: Colors.cyan, child: const Icon(Icons.person, color: Colors.black));
      },
    );
  }
}