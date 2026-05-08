class LocalChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  LocalChatMessage({required this.text, required this.isUser, required this.time});

  Map<String, dynamic> toJson() => {
    'text': text,
    'isUser': isUser,
    'time': time.toIso8601String()
  };

  factory LocalChatMessage.fromJson(Map<String, dynamic> json) => LocalChatMessage(
    text: json['text'],
    isUser: json['isUser'],
    time: DateTime.parse(json['time'])
  );
}