abstract interface class MigrationStep() {
  int get sourceVersion;
  int get targetVersion;
  Map<String, dynamic> migrate(Map<String, dynamic> payload);
}
