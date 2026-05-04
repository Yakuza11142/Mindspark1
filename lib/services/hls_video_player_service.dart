import 'package:video_player/video_player.dart';

class HlsVideoPlayerService {
  static VideoPlayerController getAdaptiveController(String videoUrl) {
    // In production, your Pexels/AWS videos should be formatted as .m3u8 (HLS)
    // This automatically adjusts resolution based on the user's internet speed in Nigeria.
    return VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
      videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false, mixWithOthers: true),
    );
  }
}