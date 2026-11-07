import 'migration_step.dart';

class MigrationRegistry(Iterable<MigrationStep> steps) {
  final Map<int, MigrationStep> _steps = {
    for (final step in steps) step.sourceVersion: step,
  };

  Map<String, dynamic> migrate(
    Map<String, dynamic> payload, {
    required int fromVersion,
    required int toVersion,
  }) {
    if (fromVersion > toVersion) {
      throw FormatException(
        'Export version $fromVersion is newer than supported version $toVersion.',
      );
    }
    var version = fromVersion;
    var result = Map<String, dynamic>.from(payload);
    while (version < toVersion) {
      final step = _steps[version];
      if (step == null || step.targetVersion <= version) {
        throw FormatException(
          'No valid migration is registered from version $version.',
        );
      }
      result = step.migrate(result);
      version = step.targetVersion;
    }
    return result;
  }
}
