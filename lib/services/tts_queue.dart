class TtsQueue {
  List<String> _queue = [];
  bool _speaking = false;
  
  void add(String text) {
    _queue.add(text);
    if (!_speaking) _playNext();
  }
  
  void _playNext() {
    // Logic to play first item then call _playNext recursively
  }
}