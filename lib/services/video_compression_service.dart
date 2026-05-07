// Requires video_compress package
class VideoCompressionService {
  static Future<void> compressForUpload(String videoPath) async {
    print("Compressing video to 720p to save  bandwidth...");
    // MediaInfo? info = await VideoCompress.compressVideo(videoPath, quality: VideoQuality.Res1280x720Quality);
  }
}