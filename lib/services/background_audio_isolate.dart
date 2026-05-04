import 'dart:isolate';

class BackgroundAudioIsolate {
  static Future<void> processAudioStream(List<int> audioBytes) async {
    ReceivePort port = ReceivePort();
    await Isolate.spawn(_decodeAudio,[port.sendPort, audioBytes]);
    // Waits for the heavy audio decoding to finish off the main thread
    await port.first; 
  }

  static void _decodeAudio(List<dynamic> args) {
    SendPort sendPort = args[0];
    // Heavy decoding computation here
    sendPort.send("Audio Processed");
  }
}