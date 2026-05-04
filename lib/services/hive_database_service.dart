import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseSettings {
  // Global configuration for all database engines
  static const String sqlDbName = "app_master.db";
  static const List<String> hiveBoxes = ['user_preferences', 'offline_cache'];
}

class GlobalDatabaseService {
  static late Database _sqlDb;

  static Future<void> init() async {
    // 1. Initialize NoSQL (Hive) for fast key-value access
    await Hive.initFlutter();
    for (var box in DatabaseSettings.hiveBoxes) {
      await Hive.openBox(box);
    }

    // 2. Initialize SQL (sqflite) for relational/complex data
    final dbPath = await getDatabasesPath();
    _sqlDb = await openDatabase(
      join(dbPath, DatabaseSettings.sqlDbName),
      version: 1,
      onCreate: (db, version) {
        // Infinite scalability: Add your tables here
        return db.execute(
          "CREATE TABLE IF NOT EXISTS records(id TEXT PRIMARY KEY, data TEXT)"
        );
      },
    );

    print("Hybrid Database Engine (SQL & NoSQL) Initialized.");
  }

  // --- NoSQL Accessors (Hive) ---
  static Box get nosql(String boxName) => Hive.box(boxName);

  // --- SQL Accessors (sqflite) ---
  static Database get sql => _sqlDb;
}
