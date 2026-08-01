import 'dart:convert';
import 'dart:developer' as developer;

/// Explicit type-safe enumeration definitions for supported library visual assets [INDEX]
enum LibraryItemType {
  lesson,
  threeDimensional,
  video;

  /// Safely parses raw network or database string tokens into valid Enum states [INDEX]
  static LibraryItemType fromString(String value) {
    switch (value.trim().toUpperCase()) {
      case 'LESSON':
        return LibraryItemType.lesson;
      case '3D':
      case 'THREEDIMENSIONAL':
        return LibraryItemType.threeDimensional;
      case 'VIDEO':
        return LibraryItemType.video;
      default:
        developer.log("⚠️ LibraryItemType: Unknown token format received: [$value]. Defaulting to lesson.");
        return LibraryItemType.lesson;
    }
  }

  /// Emits standardized string keys to satisfy database column constraints [INDEX]
  String toSerializedString() {
    switch (this) {
      case LibraryItemType.lesson:
        return 'LESSON';
      case LibraryItemType.threeDimensional:
        return '3D';
      case LibraryItemType.video:
        return 'VIDEO';
    }
  }
}

class LibraryItem {
  final String id;
  final String title;
  final LibraryItemType type; // Bound parameters strictly to type-safe Enums [INDEX]
  final DateTime dateSaved;

  const LibraryItem({
    required this.id,
    required this.title,
    required this.type,
    required this.dateSaved,
  });

  /// Factory constructor to securely convert raw JSON map data with robust fallback validation bounds [INDEX]
  factory LibraryItem.fromJson(Map<String, dynamic> json) {
    try {
      return LibraryItem(
        id: json['id']?.toString() ?? '',
        title: json['title']?.toString() ?? 'Untitled Asset',
        type: LibraryItemType.fromString(json['type']?.toString() ?? ''),
        dateSaved: json['date_saved'] != null 
            ? DateTime.parse(json['date_saved'].toString()).toUtc()
            : DateTime.now().toUtc(), // Secure chronological boundary fallback [INDEX]
      );
    } catch (e, stackTrace) {
      developer.log("❌ LibraryItem: Deserialization processing loop collapsed", error: e, stackTrace: stackTrace);
      // Safe boundary fallback returns a clean model instance instead of throwing an unhandled runtime failure [INDEX]
      return LibraryItem(
        id: 'ERROR',
        title: 'Corrupted File Record',
        type: LibraryItemType.lesson,
        dateSaved: DateTime.now().toUtc(),
      );
    }
  }

  /// Converts structural data parameters cleanly into a standard JSON map string object [INDEX]
  Map<String, dynamic> toJson() {
    return {
      'id': id.trim(),
      'title': title.trim(),
      'type': type.toSerializedString(),
      'date_saved': dateSaved.toUtc().toIso8601String(), // Standardized unified UTC date tracking strings [INDEX]
    };
  }
}
