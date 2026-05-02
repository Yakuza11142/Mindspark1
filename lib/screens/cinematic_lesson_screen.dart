import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';

class CinematicLessonScreen extends StatefulWidget {
  final String bgUrl;
  final String teacherUrl;
  const CinematicLessonScreen({super.key, required this.bgUrl, required this.teacherUrl});

  @override
  State<CinematicLessonScreen> createState() => _CinematicLessonScreenState();
}

class _CinematicLessonScreenState extends State<CinematicLessonScreen> {
  late CachedVideoPlayerController _bgCtrl;
  late CachedVideoPlayerController _teacherCtrl;

  @override
  void initState() {
    super.initState();
    _bgCtrl = CachedVideoPlayerController.network(widget.bgUrl)..initialize().then((_) { _bgCtrl.setLooping(true); _bgCtrl.play(); });
    _teacherCtrl = CachedVideoPlayerController.network(widget.teacherUrl)..initialize().then((_) { _teacherCtrl.play(); setState((){}); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children:[
          // 1. THE BACKGROUND (Runway Gen-3) - Fills the whole screen
          if (_bgCtrl.value.isInitialized)
            SizedBox.expand(child: FittedBox(fit: BoxFit.cover, child: SizedBox(width: _bgCtrl.value.size.width, height: _bgCtrl.value.size.height, child: CachedVideoPlayer(_bgCtrl)))),
          
          // 2. THE TEACHER (HeyGen) - Hovering in the bottom right corner
          Positioned(
            bottom: 50, right: 20,
            width: 150, height: 250,
            child: _teacherCtrl.value.isInitialized 
              ? CachedVideoPlayer(_teacherCtrl) 
              : const Center(child: CircularProgressIndicator(color: Colors.amber)),
          ),

          // 3. UI OVERLAYS
          const Positioned(top: 50, left: 20, child: BackButton(color: Colors.white)),
        ],
      ),
    );
  }
}