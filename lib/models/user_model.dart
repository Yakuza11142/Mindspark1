import 'dart:convert';
import 'dart:developer' as developer;

class UserModel {
  // Sealed fields with the final keyword to enforce thread-safe, immutable data contracts [INDEX]
  final String id;
  final String name;
  final int xp;

  const UserModel({
    required this.id,
    required this.name,
    required this.xp,
  });

  /// Factory constructor to securely convert raw JSON map rows with defensive fallback validation bounds [INDEX]
  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserModel(
        id: json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? 'Anonymous User',
        // Defensively parse strings or numbers into the target integer data slot smoothly [INDEX]
        xp: int.tryParse(json['xp'].toString()) ?? 0,
      );
    } catch (e, stackTrace) {
      developer.log("❌ UserModel: Deserialization processing loop collapsed seamlessly", error: e, stackTrace: stackTrace);
      // Safe boundary fallback returns a clean model instance instead of throwing an unhandled runtime failure [INDEX]
      return const UserModel(
        id: 'ERROR',
        name: 'System Recovery Account',
        xp: 0,
      );
    }
  }

  /// Converts structural data parameters cleanly into a standard JSON map string object [INDEX]
  Map<String, dynamic> toJson() {
    return {
      'id': id.trim(),
      'name': name.trim(),
      'xp': xp < 0 ? 0 : xp, // Enforce absolute lower bounds data integrity for gamification balances [INDEX]
    };
  }

  /// Implemented a standard copyWith utility to support safe data transformations while preserving immutability [INDEX]
  UserModel copyWith({
    String? id,
    String? name,
    int? xp,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      xp: xp ?? this.xp,
    );
  }
}
