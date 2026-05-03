class UserProfileModel {
  final String id;
  final String email;
  final String name;
  final int sparks;
  final int totalXp;
  final bool isPro;

  UserProfileModel({required this.id, required this.email, required this.name, required this.sparks, required this.totalXp, required this.isPro});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      sparks: json['sparks'] as int,
      totalXp: json['total_xp'] as int,
      isPro: json['is_pro'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
    'sparks': sparks,
    'total_xp': totalXp,
    'is_pro': isPro,
  };
}