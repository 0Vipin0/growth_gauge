import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/core/database/app_database.dart';

void main() {
  test('upgrades a schema version 1 database through version 3', () async {
    final directory = await Directory.systemTemp.createTemp(
      'growth_gauge_database_migration_',
    );
    final file = File(
      '${directory.path}${Platform.pathSeparator}legacy.sqlite',
    );
    AppDatabase? upgraded;

    try {
      final legacy = _SchemaV1Database(NativeDatabase(file));
      await legacy.customSelect('PRAGMA user_version').getSingle();
      await legacy.close();

      upgraded = AppDatabase(NativeDatabase(file));
      final version = await upgraded
          .customSelect('PRAGMA user_version')
          .getSingle();
      final index = await upgraded
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'index' "
            "AND name = 'muscle_volume_user_week_start'",
          )
          .get();

      expect(version.read<int>('user_version'), 3);
      expect(index, hasLength(1));
    } finally {
      await upgraded?.close();
      await directory.delete(recursive: true);
    }
  });
}

class _SchemaV1Database(super.e) extends AppDatabase {
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createTable(documents),
  );
}
