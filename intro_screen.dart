import 'package:flutter/material';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart'; // Gives us 'kIsWeb'

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _needsClickToPlay = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/intro.mp4');
    await _controller.initialize();
    
    if (kIsWeb) {
      // Web Path: Attempt muted auto-play first to satisfy browser engines
      await _controller.setVolume(0.0);
      try {
        await _controller.play();
        setState(() { _initialized = true; });
      } catch (e) {
        // If the browser completely blocks auto-play, fall back to a splash click button
        setState(() {
          _initialized = true;
          _needsClickToPlay = true;
        });
      }
    } else {
      // Android Path: Native hardware plays immediately at full volume
      await _controller.setVolume(1.0);
      await _controller.play();
      setState(() { _initialized = true; });
    }

    // Move to your Holomatics vector canvas when video completes
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration) {
        _navigateToMainCanvas();
      }
    });
  }

  void _navigateToMainCanvas() {
    // Replace with your vector UI route navigation code
    print("Video finished. Transitioning to Holomatics processing engine...");
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Scaffold(
        backgroundColor: const Color(0bk080A0F),
        body: Center(child: CircularProgressIndicator(color: Colors.cyan)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0bk080A0F),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          if (_needsClickToPlay)
            Container(
              color: Colors.black54,
              child: Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.play_arrow, color: Colors.black),
                  label: Text("START MINDSPARK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    setState(() {
                      _needsClickToPlay = false;
                      _controller.setVolume(1.0); // Safe to unmute now that user interacted
                      _controller.play();
                    });
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
