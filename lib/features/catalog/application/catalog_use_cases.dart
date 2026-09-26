import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/ids/unique_id.dart';
import '../../../core/time/app_clock.dart';
import '../domain/exercise.dart';
import '../domain/exercise_classification.dart';
import '../domain/exercise_enums.dart';
import '../domain/exercise_equipment.dart';
import '../domain/exercise_relationship.dart';
import '../domain/measurement_profile.dart';
import '../infrastructure/exercise_repository.dart';

class const CatalogUseCases(final IExerciseRepository _repository) {
  Future<Result<List<Exercise>, Failure>> list({
    String query = '',
    BodyRegion? bodyRegion,
    MovementPattern? movementPattern,
    EquipmentType? equipment,
    MuscleGroup? muscleGroup,
    bool includeArchived = false,
  }) async {
    final result = await _repository.findAll();
    return result.map((exercises) {
      final normalized = query.trim().toLowerCase();
      return exercises.where((exercise) {
        if (!includeArchived && exercise.status == ExerciseStatus.archived) {
          return false;
        }
        if (bodyRegion != null &&
            !exercise.classification.bodyRegions.contains(bodyRegion)) {
          return false;
        }
        if (movementPattern != null &&
            !exercise.classification.movementPatterns.contains(
              movementPattern,
            )) {
          return false;
        }
        if (equipment != null &&
            !exercise.equipment.requiredEquipment.contains(equipment) &&
            !exercise.equipment.optionalEquipment.contains(equipment)) {
          return false;
        }
        if (muscleGroup != null &&
            !exercise.classification.primaryMuscles.contains(muscleGroup) &&
            !exercise.classification.secondaryMuscles.contains(muscleGroup)) {
          return false;
        }
        if (normalized.isNotEmpty &&
            !exercise.name.toLowerCase().contains(normalized) &&
            !exercise.aliases.any(
              (alias) => alias.toLowerCase().contains(normalized),
            )) {
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
    BodyRegion? bodyRegion,
    MovementPattern? movementPattern,
    MuscleGroup? primaryMuscle,
    EquipmentType? equipment,
    MetricType metricType = MetricType.weightAndReps,
  }) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) {
      return const Result.error(
        ValidationFailure('Exercise name is required', 'name'),
      );
    }
    final now = AppClock.nowUtc();
    final exercise = Exercise(
      id: UniqueId.generate().value,
      name: cleanName,
      description: description.trim(),
      sourceType: ExerciseSourceType.userCreated,
      createdById: createdById,
      createdAt: now,
      updatedAt: now,
      classification: ExerciseClassification(
        bodyRegions: bodyRegion == null ? const [] : [bodyRegion],
        movementPatterns: movementPattern == null
            ? const []
            : [movementPattern],
        primaryMuscles: primaryMuscle == null ? const [] : [primaryMuscle],
      ),
      equipment: ExerciseEquipmentProfile(
        requiredEquipment: equipment == null ? const [] : [equipment],
      ),
      measurementProfile: ExerciseMeasurementProfile(
        defaultMetricType: metricType,
        supportedMetricTypes: [metricType],
        supportsWeight: metricType == MetricType.weightAndReps,
        supportsReps:
            metricType == MetricType.weightAndReps ||
            metricType == MetricType.countBased,
        supportsDuration:
            metricType == MetricType.timeBased || metricType == MetricType.pace,
        supportsDistance:
            metricType == MetricType.distanceBased ||
            metricType == MetricType.pace,
        supportsCalories: metricType == MetricType.calories,
      ),
    );
    final saved = await _repository.save(exercise);
    return saved.isError
        ? Result.error(saved.errorOrNull!)
        : Result.success(exercise);
  }

  Future<Result<void, Failure>> addRelationship({
    required String sourceExerciseId,
    required String targetExerciseId,
    required String actorId,
    required RelationshipType type,
    String? reason,
  }) async {
    if (sourceExerciseId == targetExerciseId) {
      return const Result.error(
        ValidationFailure('An exercise cannot be related to itself'),
      );
    }
    final sourceResult = await _repository.findById(sourceExerciseId);
    if (sourceResult.isError) return Result.error(sourceResult.errorOrNull!);
    final targetResult = await _repository.findById(targetExerciseId);
    if (targetResult.isError) return Result.error(targetResult.errorOrNull!);
    final source = sourceResult.dataOrNull!;
    if (source.sourceType == ExerciseSourceType.system ||
        source.createdById != actorId) {
      return Result.error(
        ConflictFailure(
          'Only the owner can edit exercise relationships',
          sourceExerciseId,
        ),
      );
    }
    if (source.relationships.any(
      (relationship) =>
          relationship.targetExerciseId == targetExerciseId &&
          relationship.type == type,
    )) {
      return Result.error(
        ConflictFailure(
          'This exercise relationship already exists',
          targetExerciseId,
        ),
      );
    }
    final updated = source.copyWith(
      relationships: [
        ...source.relationships,
        ExerciseRelationship(
          sourceExerciseId: sourceExerciseId,
          targetExerciseId: targetExerciseId,
          type: type,
          reason: reason?.trim().isEmpty == true ? null : reason?.trim(),
        ),
      ],
      updatedAt: AppClock.nowUtc(),
    );
    return _repository.save(updated);
  }

  Future<Result<void, Failure>> removeRelationship({
    required String sourceExerciseId,
    required String targetExerciseId,
    required String actorId,
    required RelationshipType type,
  }) async {
    final sourceResult = await _repository.findById(sourceExerciseId);
    if (sourceResult.isError) return Result.error(sourceResult.errorOrNull!);
    final source = sourceResult.dataOrNull!;
    if (source.sourceType == ExerciseSourceType.system ||
        source.createdById != actorId) {
      return Result.error(
        ConflictFailure(
          'Only the owner can edit exercise relationships',
          sourceExerciseId,
        ),
      );
    }
    final remaining = source.relationships
        .where(
          (relationship) =>
              relationship.targetExerciseId != targetExerciseId ||
              relationship.type != type,
        )
        .toList();
    if (remaining.length == source.relationships.length) {
      return Result.error(
        NotFoundFailure('Exercise relationship not found', targetExerciseId),
      );
    }
    return _repository.save(
      source.copyWith(relationships: remaining, updatedAt: AppClock.nowUtc()),
    );
  }

  Future<Result<void, Failure>> archive(String id) async {
    final found = await _repository.findById(id);
    if (found.isError) return Result.error(found.errorOrNull!);
    final exercise = found.dataOrNull!;
    if (exercise.sourceType == ExerciseSourceType.system) {
      return Result.error(
        ConflictFailure('System exercises cannot be changed', id),
      );
    }
    return _repository.save(
      exercise.copyWith(
        status: ExerciseStatus.archived,
        updatedAt: AppClock.nowUtc(),
      ),
    );
  }
}
