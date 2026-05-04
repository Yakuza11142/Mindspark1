import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
part 'drift_database.g.dart';

// Real SQL Table Definition
class OfflineLessons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get topic => text()();
  TextColumn get content => text()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [OfflineLessons])
class MindSparkDatabase extends _$MindSparkDatabase {
  MindSparkDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  // Real SQL Queries
  Future<int> insertLesson(OfflineLessonsCompanion lesson) => into(offlineLessons).insert(lesson);
  Future<List<OfflineLesson>> getAllLessons() => select(offlineLessons).get();
  Future<OfflineLesson> getLesson(String topic) => (select(offlineLessons)..where((tbl) => tbl.topic.equals(topic))).getSingle();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'mindspark_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}