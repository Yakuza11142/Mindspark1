import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../services/brain_service.dart';
import '../services/media_engine.dart';
import '../services/audio_service.dart';
import '../engines/tripo_engine.dart';

class LessonScreen extends StatefulWidget {
  final String topic;
  final bool isPro;
  const LessonScreen({super.key, required this.topic, required this.isPro});
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  CachedVideoPlayerController? _vidCtrl;
  String? text;
  Map<String, dynamic>? media;
  String? tripoModel;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    String txt = await context.read<BrainService>().generateLesson(widget.topic, widget.isPro, false);
    var vis = await context.read<MediaEngine>().fetchVisuals(widget.topic, widget.isPro);
    
    if (vis['type'] == 'VIDEO') {
      _vidCtrl = CachedVideoPlayerController.network(vis['url'])..initialize().then((_) { _vidCtrl!.play(); setState((){}); });
    }
    
    context.read<AudioService>().speak(txt);
    
    // Generate 3D in background
    if (widget.isPro) {
      TripoEngine().generate3D(widget.topic).then((url) => setState(() => tripoModel = url));
    }

    if(mounted) setState(() { text = txt; media = vis; });
  }

  @override
  void dispose() {
    context.read<AudioService>().stop();
    _vidCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: tripoModel != null 
              ? ModelViewer(src: tripoModel!, ar: true, autoRotate: true)
              : (_vidCtrl != null && _vidCtrl!.value.isInitialized ? CachedVideoPlayer(_vidCtrl!) : Container(color: Colors.black)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300, color: Colors.black54, padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(child: Text(text ?? "Loading...", style: const TextStyle(fontSize: 18))),
            ),
          ),
          Positioned(top: 40, left: 10, child: const BackButton()),
        ],
      ),
    );
  }
}