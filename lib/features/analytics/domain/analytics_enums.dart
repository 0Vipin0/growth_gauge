/// Distinct personal record categories tracked per exercise.
enum PrType() {
  /// Heaviest absolute weight lifted in a single set.
  maxWeight,

  /// Estimated one-rep max using the Epley formula.
  estimated1Rm,

  /// Most reps completed at a specific weight.
  maxRepsAtWeight,

  /// Highest single-set volume: weight × reps.
  maxVolumeSet,

  /// Highest total exercise volume across a session.
  maxVolumeSession,
}
