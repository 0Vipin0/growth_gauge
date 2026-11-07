import '../migration_step.dart';

class MigrationV2ToV3() implements MigrationStep {
  @override
  int get sourceVersion => 2;
  @override
  int get targetVersion => 3;

  @override
  Map<String, dynamic> migrate(Map<String, dynamic> payload) {
    final migrated = Map<String, dynamic>.from(payload);
    migrated['revisions'] ??=
        migrated.remove('templateRevisions') ?? <dynamic>[];
    migrated.putIfAbsent('equipment', () => <dynamic>[]);
    return migrated;
  }
}
