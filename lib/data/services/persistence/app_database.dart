import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Users extends Table {
  TextColumn get id => text()();
  DateTimeColumn get creationDate => dateTime()();
  DateTimeColumn get lastAssessmentDate => dateTime().nullable()();
  IntColumn get fitnessScore => integer().nullable()();
  TextColumn get dataJson => text().nullable()();
  TextColumn get assessmentJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Activities extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  IntColumn get type => integer()();
  TextColumn get unit => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get goalId => text().nullable()();
  TextColumn get tags => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class ActivityLogs extends Table {
  TextColumn get id => text()();
  TextColumn get activityId => text()();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get value => real()();
  TextColumn get notes => text().nullable()();
  IntColumn get rpe => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Goals extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  RealColumn get targetValue => real().nullable()();
  RealColumn get currentValue => real().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkoutTemplates extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get stepsJson => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
    tables: [Users, Activities, ActivityLogs, Goals, WorkoutTemplates])
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.e);

  static Future<AppDatabase> open() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'growth_gauge.sqlite'));
    return AppDatabase._(NativeDatabase(file));
  }

  // For tests, allow creating an in-memory DB
  factory AppDatabase.inMemory() => AppDatabase._(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
}
