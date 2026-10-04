import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import 'exercise_repository.dart';
import 'seed/exercise_seed_data.dart';

/// Installs the bundled catalog exactly once, only when no exercises exist.
class const CatalogSeeder(final IExerciseRepository _repository) {
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
}
