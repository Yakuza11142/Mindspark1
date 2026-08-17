import 'package:flutter/material.dart';
import 'dart:math' as math;

// Replace this with the actual path to your real home/dashboard screen
import 'package:mindspark1/screens/home_screen.dart'; 

import 'spatial_stub.dart'
    if (dart.library.html) 'spatial_web.dart'
    if (dart.library.io) 'spatial_mobile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MindSparkApp());
}

class MindSparkApp extends StatelessWidget {
  const MindSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Spark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // Replace HomeScreen() with the exact name of your main dashboard widget
      home: const HomeScreen(), 
    );
  }
}
