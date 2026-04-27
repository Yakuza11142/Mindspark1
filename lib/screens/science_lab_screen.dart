import 'dart:async';
import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:vibration/vibration.dart';
import 'dart:math' as math;

class ScienceLabScreen extends StatefulWidget {
  const ScienceLabScreen({super.key});

  @override
  State<ScienceLabScreen> createState() => _ScienceLabScreenState();
}

class _ScienceLabScreenState extends State<ScienceLabScreen> with SingleTickerProviderStateMixin {
  // MODES
  int _mode = 0; // 0 = Hologram, 1 = Color Light, 2 = Vibration

  // HOLOGRAM VARS
  late AnimationController _controller;

  // LIGHT VARS
  Color _lightColor = Colors.white;
  double _brightness = 1.0;

  // VIBRATION VARS
  bool _isVibrating = false;

  @override
  void initState() {
    super.initState();
    // Animation for Hologram (Spinning Earth)
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _setMaxBrightness();
  }

  void _setMaxBrightness() async {
    try {
      await ScreenBrightness().setScreenBrightness(1.0);
    } catch (e) {
      print("Brightness Error: $e");
    }
  }

  void _resetBrightness() async {
    await ScreenBrightness().resetScreenBrightness();
  }

  @override
  void dispose() {
    _controller.dispose();
    _resetBrightness(); // Reset when leaving screen
    super.dispose();
  }

  // VIBRATION LOGIC
  void _toggleVibration() async {
    if (_isVibrating) {
      Vibration.cancel();
      setState(() => _isVibrating = false);
    } else {
      if (await Vibration.hasCustomVibrationsSupport() ?? false) {
        Vibration.vibrate(pattern: [500, 1000, 500, 2000], repeat: 0); // Heartbeat pattern
        setState(() => _isVibrating = true);
      } else {
        Vibration.vibrate(duration: 10000);
        setState(() => _isVibrating = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mode == 1 ? _lightColor : Colors.black,
      appBar: _mode == 1 ? null : AppBar( // Hide Appbar in Light Mode
        title: const Text("Physics Lab"),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _mode,
        onTap: (i) => setState(() => _mode = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.change_history), label: "Hologram"),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb), label: "Color Caster"),
          BottomNavigationBarItem(icon: Icon(Icons.vibration), label: "Frequency"),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_mode) {
      case 0: return _buildHologram();
      case 1: return _buildColorCaster();
      case 2: return _buildVibrationLab();
      default: return Container();
    }
  }

  // 1. HOLOGRAM (Pepper's Ghost)
  // Shows 4 images. User places plastic pyramid in center.
  Widget _buildHologram() {
    return Stack(
      children: [
        Center(child: _rotatingObj(0)), // Bottom
        Positioned(top: 100, left: 0, right: 0, child: _rotatingObj(math.pi)), // Top (Inverted)
        Positioned(left: 50, top: 0, bottom: 0, child: _rotatingObj(math.pi / 2)), // Right
        Positioned(right: 50, top: 0, bottom: 0, child: _rotatingObj(-math.pi / 2)), // Left
        const Center(child: Text("+", style: TextStyle(color: Colors.white, fontSize: 20))), // Center Marker
      ],
    );
  }

  Widget _rotatingObj(double angle) {
    return Transform.rotate(
      angle: angle,
      child: RotationTransition(
        turns: _controller,
        child: const Icon(Icons.public, size: 80, color: Colors.blueAccent), // Replace with 3D Image
      ),
    );
  }

  // 2. COLOR CASTER (Screen Light)
  Widget _buildColorCaster() {
    return GestureDetector(
      onTap: () {
        // Cycle Colors on Tap
        List<Color> colors = [Colors.red, Colors.green, Colors.blue, Colors.purple, Colors.white];
        int index = colors.indexOf(_lightColor);
        setState(() {
          _lightColor = colors[(index + 1) % colors.length];
        });
      },
      child: Container(
        color: _lightColor,
        width: double.infinity,
        height: double.infinity,
        child: const Center(
          child: Text("Tap to Change Color\nPoint screen at wall", textAlign: TextAlign.center, style: TextStyle(color: Colors.black54)),
        ),
      ),
    );
  }

  // 3. VIBRATION LAB
  Widget _buildVibrationLab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.speaker_phone, size: 100, color: _isVibrating ? Colors.redAccent : Colors.grey),
          const SizedBox(height: 20),
          const Text("Resonance Engine", style: TextStyle(color: Colors.white, fontSize: 24)),
          const Text("Place phone on a hollow box to hear the sound.", style: TextStyle(color: Colors.white54)),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _toggleVibration,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isVibrating ? Colors.red : Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20)
            ),
            child: Text(_isVibrating ? "STOP FREQUENCY" : "START FREQUENCY"),
          )
        ],
      ),
    );
  }
}