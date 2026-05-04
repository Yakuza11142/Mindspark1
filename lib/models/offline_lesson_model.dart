class OfflineLessonModel {
  final String topic;
  final String content;
  final int timestamp;

  OfflineLessonModel(this.topic, this.content, this.timestamp);

  Map<String, dynamic> toJson() => {'topic': topic, 'content': content, 'timestamp': timestamp};
  
  factory OfflineLessonModel.fromJson(Map<dynamic, dynamic> json) {
    return OfflineLessonModel(json['topic'], json['content'], json['timestamp']);
  }
}