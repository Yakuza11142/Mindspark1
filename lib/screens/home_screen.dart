// ADD THESE VARIABLES AT TOP OF _HomeScreenState
final VoiceInputService _voice = VoiceInputService();
bool _isListening = false;

@override
void initState() {
  super.initState();
  _voice.init(); // Turn on the ears
  // ... other init code ...
}

// ... INSIDE BUILD METHOD ...

// REPLACEMENT SEARCH BAR
GlassContainer(
  child: TextField(
    controller: _searchCtrl,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: _isListening ? "Listening..." : "Type OR use Mic",
      hintStyle: TextStyle(color: _isListening ? Colors.greenAccent : Colors.white38),
      border: InputBorder.none,
      prefixIcon: const Icon(Icons.search, color: Colors.white),
      
      // THE NEW MICROPHONE BUTTON
      suffixIcon: IconButton(
        icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
        color: _isListening ? Colors.greenAccent : Colors.white,
        onPressed: () {
          if (_isListening) {
            _voice.stopListening();
            setState(() => _isListening = false);
            // Auto-submit if text exists
            if (_searchCtrl.text.isNotEmpty) {
               Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(topic: _searchCtrl.text, isPro: isPro, isPidgin: isPidgin)));
            }
          } else {
            setState(() => _isListening = true);
            _voice.startListening((text) {
              setState(() => _searchCtrl.text = text);
            });
          }
        },
      ),
    ),
    onSubmitted: (val) {
      // ... your navigation code ...
    },
  ),
),