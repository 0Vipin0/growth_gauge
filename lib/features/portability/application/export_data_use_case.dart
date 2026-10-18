import 'dart:convert';

import '../../../core/database/app_database.dart';
import '../../../core/time/app_clock.dart';
import '../domain/export_envelope.dart';
import '../domain/export_manifest.dart';
import '../migration/checksum_validator.dart';

class ExportDataUseCase({
  required final AppDatabase database,
  final ChecksumValidator? checksumValidator,
}) {
  final AppDatabase _database = database;
  final ChecksumValidator _checksumValidator =
      checksumValidator ?? const ChecksumValidator();

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
    final payload = {
      for (final key in ExportEnvelope.collectionKeys)
        key: <Map<String, dynamic>>[],
    };
    for (final row in rows) {
      final key = collectionNames[row.collection];
      if (key == null) continue;
      final decoded = jsonDecode(row.jsonData);
      if (decoded is! Map) {
        throw const FormatException('A stored document is not a JSON object.');
      }
      payload[key]!.add(Map<String, dynamic>.from(decoded));
    }
    for (final values in payload.values) {
      values.sort((a, b) => _entityId(a).compareTo(_entityId(b)));
    }
    return ExportEnvelope(
      manifest: ExportManifest(
        formatVersion: 3,
        exportedAt: AppClock.nowUtc(),
        appVersion: appVersion,
        generator: 'growth-gauge',
        checksum: _checksumValidator.checksum(payload),
        featureFlags: const [
          'REST_INTERVALS',
          'SESSION_RECOVERY',
          'RPE_RIR',
          'GOALS',
        ],
      ),
      payload: payload,
    );
  }

  static String _entityId(Map<String, dynamic> document) =>
      (document['id'] ?? document['userId'] ?? '').toString();
}
