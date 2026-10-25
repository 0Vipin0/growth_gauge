/// Policy applied when an imported document already exists locally.
enum ConflictStrategy() {
  keepExisting,
  overwrite,
  duplicateWithNewId,
}
