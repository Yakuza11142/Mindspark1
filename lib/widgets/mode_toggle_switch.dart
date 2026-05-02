import 'package:flutter/material.dart';
import '../services/system_mode_controller.dart';

class ModeToggleSwitch extends StatefulWidget {
  const ModeToggleSwitch({super.key});
  @override
  State<ModeToggleSwitch> createState() => _ModeToggleSwitchState();
}

class _ModeToggleSwitchState extends State<ModeToggleSwitch> {
  bool isExamMode = false;

  @override
  void initState() {
    super.initState();
    SystemModeController.getMode().then((m) => setState(() => isExamMode = m == "EXAM"));
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Exam Focus Mode"),
      subtitle: const Text("Turns off general browsing and focuses on syllabus."),
      activeColor: Colors.redAccent,
      value: isExamMode,
      onChanged: (v) {
        setState(() => isExamMode = v);
        SystemModeController.setMode(v ? "EXAM" : "EXPLORE");
      },
    );
  }
}