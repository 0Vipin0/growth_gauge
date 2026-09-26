import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../../../core/ids/unique_id.dart';
import '../../../core/time/app_clock.dart';
import '../domain/template_enums.dart';
import '../domain/workout_block.dart';
import '../domain/workout_template.dart';
import '../domain/workout_template_revision.dart';
import '../infrastructure/template_repository.dart';

class TemplateUseCases {
  const TemplateUseCases(this._repository);
  final ITemplateRepository _repository;

  Future<Result<WorkoutTemplate, Failure>> create({required String name, required String createdById, String description = ''}) async {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return const Result.error(ValidationFailure('Template name is required', 'name'));
    final now = AppClock.nowUtc();
    final templateId = UniqueId.generate().value;
    final revision = WorkoutTemplateRevision(
      id: UniqueId.generate().value,
      templateId: templateId,
      revisionNumber: 1,
      createdById: createdById,
      createdAt: now,
    );
    final template = WorkoutTemplate(
      id: templateId,
      name: cleanName,
      description: description.trim(),
      currentRevisionId: revision.id,
      createdById: createdById,
      createdAt: now,
      updatedAt: now,
    );
    final saved = await _repository.saveTemplate(template);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    final revisionSaved = await _repository.saveRevision(revision);
    if (revisionSaved.isError) return Result.error(revisionSaved.errorOrNull!);
    return Result.success(template);
  }

  Future<Result<WorkoutTemplateRevision, Failure>> createDraftFromCurrent(String templateId, {String changeSummary = ''}) async {
    final templateResult = await _repository.getTemplate(templateId);
    if (templateResult.isError) return Result.error(templateResult.errorOrNull!);
    final template = templateResult.dataOrNull!;
    final revisionsResult = await _repository.getRevisions(templateId);
    if (revisionsResult.isError) return Result.error(revisionsResult.errorOrNull!);
    final revisions = revisionsResult.dataOrNull!;
    WorkoutTemplateRevision? current;
    for (final revision in revisions) {
      if (revision.id == template.currentRevisionId) current = revision;
    }
    if (current == null) return Result.error(NotFoundFailure('Current template revision not found', template.currentRevisionId ?? templateId));
    if (current.status == TemplateRevisionStatus.draft) {
      return Result.error(ConflictFailure('A draft revision already exists', current.id));
    }
    final draft = current.copyWith(
      id: UniqueId.generate().value,
      revisionNumber: revisions.fold<int>(0, (max, r) => r.revisionNumber > max ? r.revisionNumber : max) + 1,
      status: TemplateRevisionStatus.draft,
      createdAt: AppClock.nowUtc(),
      changeSummary: changeSummary,
    );
    final saved = await _repository.saveRevision(draft);
    if (saved.isError) return Result.error(saved.errorOrNull!);
    final updatedTemplate = template.copyWith(currentRevisionId: draft.id, updatedAt: AppClock.nowUtc());
    final updated = await _repository.saveTemplate(updatedTemplate);
    if (updated.isError) return Result.error(updated.errorOrNull!);
    return Result.success(draft);
  }

  Future<Result<WorkoutTemplateRevision, Failure>> updateDraftBlocks(String revisionId, List<WorkoutBlock> blocks) async {
    final found = await _repository.getRevision(revisionId);
    if (found.isError) return Result.error(found.errorOrNull!);
    final revision = found.dataOrNull!;
    if (revision.status != TemplateRevisionStatus.draft) {
      return Result.error(ConflictFailure('Only draft revisions can be edited', revisionId));
    }
    final updated = revision.copyWith(blocks: blocks);
    final saved = await _repository.saveRevision(updated);
    return saved.isError ? Result.error(saved.errorOrNull!) : Result.success(updated);
  }

  Future<Result<void, Failure>> publish(String revisionId) async {
    final found = await _repository.getRevision(revisionId);
    if (found.isError) return Result.error(found.errorOrNull!);
    final revision = found.dataOrNull!;
    if (revision.status != TemplateRevisionStatus.draft) {
      return Result.error(ConflictFailure('Only draft revisions can be published', revisionId));
    }
    final published = await _repository.saveRevision(revision.copyWith(status: TemplateRevisionStatus.published));
    if (published.isError) return published;
    final templateResult = await _repository.getTemplate(revision.templateId);
    if (templateResult.isError) return Result.error(templateResult.errorOrNull!);
    return _repository.saveTemplate(templateResult.dataOrNull!.copyWith(currentRevisionId: revisionId, updatedAt: AppClock.nowUtc()));
  }
}
