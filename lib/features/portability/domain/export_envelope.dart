import 'export_manifest.dart';

/// Versioned portable archive. Analytics read models are deliberately omitted.
class const ExportEnvelope({
  required final ExportManifest manifest,
  required final Map<String, List<Map<String, dynamic>>> payload,
}) {
  static const collectionKeys = [
    'users',
    'profiles',
    'trainingProfiles',
    'preferences',
    'goals',
    'equipment',
    'exercises',
    'templates',
    'revisions',
    'sessions',
    'measurements',
  ];

  Map<String, dynamic> toJson() => {'manifest': manifest.toJson(), ...payload};

  factory fromJson(Map<String, dynamic> json) {
    final manifestJson = json['manifest'];
    if (manifestJson is! Map<String, dynamic>) {
      throw const FormatException('Export manifest is missing.');
    }
    final payload = <String, List<Map<String, dynamic>>>{};
    for (final key in collectionKeys) {
      final rows =
          json[key] ?? (key == 'revisions' ? json['templateRevisions'] : null);
      if (rows == null) {
        payload[key] = <Map<String, dynamic>>[];
        continue;
      }
      if (rows is! List) throw FormatException('"$key" must be an array.');
      payload[key] = rows
          .map((row) {
            if (row is! Map) {
              throw FormatException('"$key" entries must be objects.');
            }
            return Map<String, dynamic>.from(row);
          })
          .toList(growable: false);
    }
    return ExportEnvelope(
      manifest: ExportManifest.fromJson(manifestJson),
      payload: payload,
    );
  }
}
