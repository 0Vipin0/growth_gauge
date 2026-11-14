import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/exercise_enums.dart';
import 'exercise_repository.dart';
import 'seed/exercise_seed_data.dart';

/// Installs and reconciles the bundled exercise catalog.
class const CatalogSeeder(final IExerciseRepository _repository) {
  /// Seeds all exercises only when no exercises exist in the database.
  Future<Result<int, Failure>> seedIfEmpty() async {
    final count = await _repository.count();
    if (count.isError) return Result.error(count.errorOrNull!);
    if (count.dataOrNull != 0) return const Result.success(0);

    var inserted = 0;
    for (final exercise in ExerciseSeedData.all) {
      final result = await _repository.save(exercise);
      if (result.isError) return Result.error(result.errorOrNull!);
      inserted++;
    }
    return Result.success(inserted);
  }

  /// Safely seeds missing system exercises and updates system-owned exercises,
  /// preserving user-created and custom exercises without modification.
  ///
  /// Returns the count of reconciled system exercises.
  Future<Result<int, Failure>> seedOrUpdate() async {
    var reconciled = 0;
    for (final exercise in ExerciseSeedData.all) {
      final existingResult = await _repository.findById(exercise.id);
      if (existingResult.isError) {
        // Exercise does not exist in store -> insert as new
        final saveResult = await _repository.save(exercise);
        if (saveResult.isError) return Result.error(saveResult.errorOrNull!);
        reconciled++;
      } else {
        final current = existingResult.dataOrNull;
        // Only update if existing record is system-owned
        if (current != null &&
            current.sourceType == ExerciseSourceType.system) {
          final saveResult = await _repository.save(exercise);
          if (saveResult.isError) return Result.error(saveResult.errorOrNull!);
          reconciled++;
        }
        // User-created exercises are strictly protected and never overwritten
      }
    }
    return Result.success(reconciled);
  }
}
