import 'package:flutter/material.dart';

class PremiumBanner extends StatelessWidget {
  final VoidCallback onTap;
  const PremiumBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Colors.amber, Colors.orange]),
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Row(
          children: [
            Icon(Icons.star, color: Colors.black),
            SizedBox(width: 10),
            Text("Upgrade to Elite", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}