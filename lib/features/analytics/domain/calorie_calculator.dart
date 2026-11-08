import 'daily_workout_summary.dart';

/// Pure domain utility for estimating caloric expenditure during workouts.
///
/// Combines metabolic equivalent of task (MET) duration modeling with
/// mechanical volume work scaling.
class const CalorieCalculator._() {
  /// Estimates calories burned during a resistance or functional training session.
  ///
  /// - [activeSeconds]: Total active training time in seconds (excluding rest/pause).
  /// - [volumeLoadKg]: Total volume load in kilograms (sum of weight * reps).
  /// - [userWeightKg]: Body weight in kilograms (defaults to 75.0 kg baseline).
  /// - [met]: Metabolic Equivalent of Task (defaults to 6.0 for resistance training).
  static int estimateBurned({
    required int activeSeconds,
    required double volumeLoadKg,
    double userWeightKg = 75.0,
    double met = 6.0,
  }) {
    if (activeSeconds <= 0 && volumeLoadKg <= 0) return 0;

    final activeMinutes = (activeSeconds > 0 ? activeSeconds : 0) / 60.0;
    final burnRatePerMinute = (met * 3.5 * userWeightKg) / 200.0;
    final baseCalories = activeMinutes * burnRatePerMinute;

    final validVolume = volumeLoadKg > 0 ? volumeLoadKg : 0.0;
    final volumeCalories = validVolume * 0.015;

    final total = baseCalories + volumeCalories;
    return total.round();
  }
}

/// Extension on collections of [DailyWorkoutSummary] to calculate aggregate calories.
extension DailyWorkoutSummaryCalorieX on Iterable<DailyWorkoutSummary> {
  /// Computes the total estimated calories burned across all summaries in this collection.
  int calculateTotalCalories({double userWeightKg = 75.0}) {
    return fold<int>(
      0,
      (sum, item) =>
          sum +
          CalorieCalculator.estimateBurned(
            activeSeconds: item.activeSeconds,
            volumeLoadKg: item.volumeLoadKg,
            userWeightKg: userWeightKg,
          ),
    );
  }
}
