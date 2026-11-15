class const ExportManifest({
  required final int formatVersion,
  required final DateTime exportedAt,
  required final String appVersion,
  required final String generator,
  required final String checksum,
  final List<String> featureFlags = const [],
}) {
  Map<String, Object?> toJson() => {
    'formatVersion': formatVersion,
    'exportedAt': exportedAt.toUtc().toIso8601String(),
    'appVersion': appVersion,
    'generator': generator,
    'checksum': checksum,
    'featureFlags': featureFlags,
  };

  factory fromJson(Map<String, dynamic> json) {
    final version = json['formatVersion'];
    final exportedAt = DateTime.tryParse(json['exportedAt']?.toString() ?? '');
    if (version is! int || exportedAt == null) {
      throw const FormatException('Invalid export manifest.');
    }
    return ExportManifest(
      formatVersion: version,
      exportedAt: exportedAt,
      appVersion: json['appVersion']?.toString() ?? 'unknown',
      generator: json['generator']?.toString() ?? 'unknown',
      checksum: json['checksum']?.toString() ?? '',
      featureFlags: (json['featureFlags'] as List<dynamic>? ?? const [])
          .map((value) => value.toString())
          .toList(growable: false),
    );
  }
}
