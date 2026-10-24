import 'dart:convert';

import '../../../core/concurrency/isolate_runner.dart';
import '../../../core/database/app_database.dart';
import '../../../core/time/app_clock.dart';
import '../domain/export_envelope.dart';
import '../domain/export_manifest.dart';
import '../migration/checksum_validator.dart';

class ExportDataUseCase({
  required final AppDatabase database,
  final ChecksumValidator? checksumValidator,
  final IsolateRunner isolateRunner = const IsolateRunner(),
}) {
  final AppDatabase _database = database;
  final ChecksumValidator _checksumValidator =
      checksumValidator ?? const ChecksumValidator();
  final IsolateRunner _isolateRunner = isolateRunner;

  Future<ExportEnvelope> call({String appVersion = 'unknown'}) async {
    final rows = await _database.select(_database.documents).get();
    const collectionNames = {
      'user_accounts': 'users',
      'profiles': 'profiles',
      'training_profiles': 'trainingProfiles',
      'preferences': 'preferences',
      'goals': 'goals',
      'equipment_inventories': 'equipment',
      'exercises': 'exercises',
      'workout_templates': 'templates',
      'workout_template_revisions': 'revisions',
      'workout_sessions': 'sessions',
      'measurements': 'measurements',
    };
    final portableRows = rows
        .where((row) => collectionNames.containsKey(row.collection))
        .map((row) => (collectionNames[row.collection]!, row.jsonData))
        .toList();
    final prepared = await _isolateRunner.run(
      _prepareExportPayload,
      portableRows,
    );
    return ExportEnvelope(
      manifest: ExportManifest(
        formatVersion: 3,
        exportedAt: AppClock.nowUtc(),
        appVersion: appVersion,
        generator: 'growth-gauge',
        checksum: await _isolateRunner.run(_checksumPayload, (
          prepared,
          _checksumValidator,
        )),
        featureFlags: const [
          'REST_INTERVALS',
          'SESSION_RECOVERY',
          'RPE_RIR',
          'GOALS',
        ],
      ),
      payload: prepared,
    );
  }
}

Map<String, List<Map<String, dynamic>>> _prepareExportPayload(
  List<(String, String)> rows,
) {
  final payload = {
    for (final key in ExportEnvelope.collectionKeys)
      key: <Map<String, dynamic>>[],
  };
  for (final (key, jsonData) in rows) {
    final decoded = jsonDecode(jsonData);
    if (decoded is! Map) {
      throw const FormatException('A stored document is not a JSON object.');
    }
    payload[key]!.add(Map<String, dynamic>.from(decoded));
  }
  for (final values in payload.values) {
    values.sort((a, b) => _entityId(a).compareTo(_entityId(b)));
  }
  return payload;
}

String _checksumPayload(
  (Map<String, List<Map<String, dynamic>>>, ChecksumValidator) message,
) => message.$2.checksum(message.$1);

String _entityId(Map<String, dynamic> document) =>
    (document['id'] ?? document['userId'] ?? '').toString();
