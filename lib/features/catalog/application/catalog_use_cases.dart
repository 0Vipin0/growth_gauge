import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/ids/unique_id.dart';
import '../../../core/time/app_clock.dart';
import '../domain/exercise.dart';
import '../domain/exercise_enums.dart';
import '../infrastructure/exercise_repository.dart';

class CatalogUseCases {
  const CatalogUseCases(this._repository);

  final IExerciseRepository _repository;

  Future<Result<List<Exercise>, Failure>> list({
    String query = '',
    BodyRegion? bodyRegion,
    MovementPattern? movementPattern,
    EquipmentType? equipment,
    bool includeArchived = false,
  }) async {
    final result = await _repository.findAll();
    return result.map((exercises) {
      final normalized = query.trim().toLowerCase();
      return exercises.where((exercise) {
        if (!includeArchived && exercise.status == ExerciseStatus.archived)
          return false;
        if (bodyRegion != null &&
            !exercise.classification.bodyRegions.contains(bodyRegion))
          return false;
        if (movementPattern != null &&
            !exercise.classification.movementPatterns.contains(movementPattern))
          return false;
        if (equipment != null &&
            !exercise.equipment.requiredEquipment.contains(equipment))
          return false;
        if (normalized.isNotEmpty &&
            !exercise.name.toLowerCase().contains(normalized) &&
            !exercise.aliases
                .any((alias) => alias.toLowerCase().contains(normalized))) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  Future<Result<Exercise, Failure>> createCustom({
    required String name,
    required String createdById,
    String description = '',
  }) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty)
      return const Result.error(
          ValidationFailure('Exercise name is required', 'name'));
    final now = AppClock.nowUtc();
    final exercise = Exercise(
      id: UniqueId.generate().value,
      name: cleanName,
      description: description.trim(),
      sourceType: ExerciseSourceType.userCreated,
      createdById: createdById,
      createdAt: now,
      updatedAt: now,
    );
    final saved = await _repository.save(exercise);
    return saved.isError
        ? Result.error(saved.errorOrNull!)
        : Result.success(exercise);
  }

  Future<Result<void, Failure>> archive(String id) async {
    final found = await _repository.findById(id);
    if (found.isError) return Result.error(found.errorOrNull!);
    final exercise = found.dataOrNull!;
    if (exercise.sourceType == ExerciseSourceType.system) {
      return Result.error(
          ConflictFailure('System exercises cannot be changed', id));
    }
    return _repository.save(exercise.copyWith(
        status: ExerciseStatus.archived, updatedAt: AppClock.nowUtc()));
  }
}
