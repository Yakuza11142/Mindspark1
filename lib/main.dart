import 'package:flutter/material.dart';
import 'package:mindspark1/screens/main_layout_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MindSparkApp());
}

class MindSparkApp extends StatelessWidget {
  const MindSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindSpark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainLayoutScreen(),
    );
  }
}
