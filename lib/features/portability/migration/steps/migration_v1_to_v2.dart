import '../migration_step.dart';

class MigrationV1ToV2() implements MigrationStep {
  @override
  int get sourceVersion => 1;
  @override
  int get targetVersion => 2;

  @override
  Map<String, dynamic> migrate(Map<String, dynamic> payload) => {
    for (final key in payload.keys) key: payload[key],
    'equipment': payload['equipment'] ?? <dynamic>[],
    'measurements': payload['measurements'] ?? <dynamic>[],
  };
}
