import 'dart:convert';
import 'dart:developer' as developer;

class UserProfileModel {
  // Sealed fields with final properties to guarantee thread-safe data contracts [INDEX]
  final String id;
  final String email;
  final String name;
  final int sparks;
  final int totalXp;
  final bool isPro;

  const UserProfileModel({
    required this.id,
    required this.email,
    required this.name,
    required this.sparks,
    required this.totalXp,
    required this.isPro,
  });

  /// Factory constructor to securely convert raw JSON map data rows with robust fallback validation bounds [INDEX]
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserProfileModel(
        // Swapped out loose raw casts for safe string conversions and explicit integer parsers [INDEX]
        id: json['id']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        name: json['name']?.toString() ?? 'Anonymous Scholar',
        sparks: int.tryParse(json['sparks'].toString()) ?? 0,
        totalXp: int.tryParse(json['total_xp'].toString()) ?? 0,
        isPro: json['is_pro'] == true, // Defensive boolean matching prevents casting crashes [INDEX]
      );
    } catch (e, stackTrace) {
      // Attached robust logging telemetry hooks to capture database configuration mismatches safely [INDEX]
      developer.log("❌ UserProfileModel: Deserialization processing loop collapsed seamlessly", error: e, stackTrace: stackTrace);
      
      // Safe boundary fallback returns a clean model instance instead of throwing an unhandled runtime failure [INDEX]
      return const UserProfileModel(
        id: 'ERROR',
        email: 'error@mindspark.ai',
        name: 'Emergency Recovery Profile',
        sparks: 0,
        totalXp: 0,
        isPro: false,
      );
    }
  }

  /// Converts structural data parameters cleanly into a standard JSON map string object [INDEX]
  Map<String, dynamic> toJson() {
    return {
      'id': id.trim(),
      'email': email.trim().toLowerCase(), // Enforces uniform normalization for authentication comparisons [INDEX]
      'name': name.trim(),
      'sparks': sparks < 0 ? 0 : sparks, // Enforces lower bounds gamification balance integrity [INDEX]
      'total_xp': totalXp < 0 ? 0 : totalXp,
      'is_pro': isPro,
    };
  }

  /// Implemented a standard copyWith utility to support safe data transformations while preserving immutability [INDEX]
  UserProfileModel copyWith({
    String? id,
    String? email,
    String? name,
    int? sparks,
    int? totalXp,
    bool? isPro,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      sparks: sparks ?? this.sparks,
      totalXp: totalXp ?? this.totalXp,
      isPro: isPro ?? this.isPro,
    );
  }
}
