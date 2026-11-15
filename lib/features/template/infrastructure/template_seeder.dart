import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import 'seed/workout_template_seed_data.dart';
import 'template_repository.dart';

/// Installs bundled workout templates and their initial revisions
/// exactly once, or reconciles them by seeding missing system templates
/// and updating system-owned templates while preserving user-created content.
class const TemplateSeeder(final ITemplateRepository _repository) {
  Future<Result<int, Failure>> seedIfEmpty() async {
    final existingResult = await _repository.getTemplates();
    if (existingResult.isError) {
      return Result.error(existingResult.errorOrNull!);
    }

    // If templates already exist, do nothing
    if (existingResult.dataOrNull != null &&
        existingResult.dataOrNull!.isNotEmpty) {
      return const Result.success(0);
    }

    var inserted = 0;
    for (final seedItem in WorkoutTemplateSeedData.all) {
      // 1. Save the template metadata
      final templateResult = await _repository.saveTemplate(seedItem.template);
      if (templateResult.isError) {
        return Result.error(templateResult.errorOrNull!);
      }

      // 2. Save the initial template revision
      final revisionResult = await _repository.saveRevision(
        seedItem.initialRevision,
      );
      if (revisionResult.isError) {
        return Result.error(revisionResult.errorOrNull!);
      }

      inserted++;
    }

    return Result.success(inserted);
  }

  /// Safely seeds missing system templates and updates system-owned templates,
  /// preserving user-created and custom templates without modification.
  /// Returns the count of reconciled system templates.
  Future<Result<int, Failure>> seedOrUpdate() async {
    // Ensure repository access works properly before starting update batch
    final existingResult = await _repository.getTemplates();
    if (existingResult.isError) {
      return Result.error(existingResult.errorOrNull!);
    }

    var reconciledCount = 0;

    for (final seedItem in WorkoutTemplateSeedData.all) {
      // 1. Save or update the system template metadata
      final templateResult = await _repository.saveTemplate(seedItem.template);
      if (templateResult.isError) {
        return Result.error(templateResult.errorOrNull!);
      }

      // 2. Save or update the initial template revision
      final revisionResult = await _repository.saveRevision(
        seedItem.initialRevision,
      );

      // If saving the revision fails due to it already being published (immutable),
      // we safely ignore that specific conflict error for system updates.
      if (revisionResult.isError) {
        final error = revisionResult.errorOrNull!;
        if (error is! ConflictFailure) {
          return Result.error(error);
        }
      }

      reconciledCount++;
    }

    return Result.success(reconciledCount);
  }
}
