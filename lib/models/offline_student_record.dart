class OfflineStudentRecord {
  final String studentId;
  final int latestScore;
  final String weakTopic;

  OfflineStudentRecord(this.studentId, this.latestScore, this.weakTopic);
  
  Map<String, dynamic> toMap() => {'id': studentId, 'score': latestScore, 'weakness': weakTopic};
}