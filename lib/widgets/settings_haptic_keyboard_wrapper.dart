class HapticKeyboardWrapper extends StatelessWidget {
  final Widget child;
  final bool isEnabled; // Add this flag

  const HapticKeyboardWrapper({
    super.key, 
    required this.child, 
    this.isEnabled = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        // Only trigger if focus is gained AND setting is enabled
        if (hasFocus && isEnabled) {
          HapticFeedback.lightImpact();
        }
      },
      child: child,
    );
  }
}
bool _hapticEnabled = true;

// In your Settings UI
SwitchListTile(
  title: const Text("Keyboard Haptics"),
  value: _hapticEnabled,
  onChanged: (bool value) {
    setState(() => _hapticEnabled = value);
  },
),

// Wrapping your text fields
HapticKeyboardWrapper(
  isEnabled: _hapticEnabled,
  child: TextField(
    decoration: InputDecoration(labelText: "Type here"),
  ),
),
