import 'package:flutter/material.dart';

class DynamicConfidenceBooster extends StatelessWidget {
  final int questionCount;
  final String appName;
  final Color themeColor;

  const DynamicConfidenceBooster({
    super.key, 
    required this.questionCount, 
    this.appName = "Mind Spark",
    this.themeColor = Colors.greenAccent,
  });

  @override
  Widget build(BuildContext context) {
    // Logic to change message based on effort
    String message = questionCount > 1000 
        ? "You are mathematically guaranteed to pass." 
        : "You've put in the work. Trust the process.";

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeColor.withOpacity(0.1), 
        border: Border.all(color: themeColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shield, color: themeColor, size: 50),
          const SizedBox(height: 10),
          Text(
            "You have answered ${questionCount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} questions on $appName.", 
            textAlign: TextAlign.center, 
            style: const TextStyle(color: Colors.white, fontSize: 16)
          ),
          const SizedBox(height: 8),
          Text(
            message.toUpperCase(), 
            textAlign: TextAlign.center, 
            style: TextStyle(color: themeColor, fontWeight: FontWeight.bold, letterSpacing: 1.1)
          ),
        ],
      ),
    );
  }
}
