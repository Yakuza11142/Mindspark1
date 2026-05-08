class CloudUser {
  final String id;
  final String email;
  final int sparks;
  final bool isPro;

  CloudUser({required this.id, required this.email, required this.sparks, required this.isPro});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'sparks': sparks,
      'isPro': isPro
    };
  }
}