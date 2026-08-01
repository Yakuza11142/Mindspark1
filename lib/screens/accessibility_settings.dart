import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class AccessibilitySettings extends StatefulWidget {
  const AccessibilitySettings({super.key});

  @override
  State<AccessibilitySettings> createState() => _AccessibilitySettingsState();
}

class _AccessibilitySettingsState extends State<AccessibilitySettings> {
  static const String _contrastKey = 'access_high_contrast_enabled';
  static const String _fontScaleKey = 'access_font_scale_multiplier';

  bool _highContrast = false;
  double _fontSize = 1.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load historical preference keys safely from disk during setup initialization lines [INDEX]
    _loadStoredAccessibilityPreferences();
  }

  /// Pulls historical preference profiles from local cache disks safely [INDEX]
  Future<void> _loadStoredAccessibilityPreferences() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!mounted) return;

      setState(() {
        _highContrast = prefs.getBool(_contrastKey) ?? false;
        _fontSize = prefs.getDouble(_fontScaleKey) ?? 1.0;
        _isLoading = false;
      });
      developer.log("⚙️ Accessibility: Settings loaded from disk. Contrast: $_highContrast, Font Scale: $_fontSize");
    } catch (e, stackTrace) {
      developer.log("❌ Accessibility: Failed to load preference map strings", error: e, stackTrace: stackTrace);
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Writes individual boolean switch metrics to storage disk instantly [INDEX]
  Future<void> _updateContrastPreference(bool value) async {
    setState(() => _highContrast = value);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_contrastKey, value);
      developer.log("💾 Accessibility: High contrast persistence state committed: $value");
    } catch (e) {
      developer.log("❌ Accessibility: Error writing contrast parameter to storage: $e");
    }
  }

  /// Debounces continuous I/O pressure by committing parameters only when the user finishes drags [INDEX]
  Future<void> _commitFontScaleToDisk(double value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_fontScaleKey, value);
      developer.log("💾 Accessibility: Font scaling persistent multiplier finalized on disk: $value");
    } catch (e) {
      developer.log("❌ Accessibility: Error writing font scale to storage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Accessibility Settings")),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          SwitchListTile(
            title: const Text("High Contrast Mode"),
            subtitle: const Text("Enhances text readability crosswise views"),
            value: _highContrast,
            // Trigger rapid database writes only on single discrete tap actions [INDEX]
            onChanged: _updateContrastPreference,
          ),
          const Divider(),
          ListTile(
            title: const Text("Font Scaling"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Current scale tracking: ${_fontSize.toStringAsFixed(2)}x",
                  style: TextStyle(fontSize: 14 * _fontSize),
                ),
                Slider(
                  value: _fontSize,
                  min: 0.8,
                  max: 1.5,
                  divisions: 7, // Locks alignment increments cleanly to stop infinite micro-drags [INDEX]
                  // Update local UI states smoothly without hitting disk channels during active movements [INDEX]
                  onChanged: (double value) {
                    setState(() => _fontSize = value);
                  },
                  // Save to local disk ONLY on this terminal release hook when the user lifts their finger [INDEX]
                  onChangeEnd: _commitFontScaleToDisk,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
