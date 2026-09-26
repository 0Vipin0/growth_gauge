import '../../../core/database/app_database.dart';
import '../../../core/database/document_store.dart';
import '../../../core/database/drift_document_store.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/workout_template.dart';
import '../domain/workout_template_revision.dart';
import '../domain/template_enums.dart';
import 'template_document_adapters.dart';

abstract interface class ITemplateRepository {
  Future<Result<void, Failure>> saveTemplate(WorkoutTemplate value);
  Future<Result<WorkoutTemplate, Failure>> getTemplate(String id);
  Future<Result<List<WorkoutTemplate>, Failure>> getTemplates();
  Stream<List<WorkoutTemplate>> watchTemplates();
  Future<Result<void, Failure>> saveRevision(WorkoutTemplateRevision value);
  Future<Result<WorkoutTemplateRevision, Failure>> getRevision(String id);
  Future<Result<List<WorkoutTemplateRevision>, Failure>> getRevisions(String templateId);
}

class TemplateRepository implements ITemplateRepository {
  TemplateRepository(AppDatabase db)
      : _templates = DriftDocumentStore<WorkoutTemplate>(database: db, adapter: const WorkoutTemplateDocumentAdapter()),
        _revisions = DriftDocumentStore<WorkoutTemplateRevision>(database: db, adapter: const WorkoutTemplateRevisionDocumentAdapter());

  final IDocumentStore<WorkoutTemplate> _templates;
  final IDocumentStore<WorkoutTemplateRevision> _revisions;

  @override
  Future<Result<void, Failure>> saveTemplate(WorkoutTemplate value) => _templates.upsert(value);
  @override
  Future<Result<WorkoutTemplate, Failure>> getTemplate(String id) => _templates.getById(id);
  @override
  Future<Result<List<WorkoutTemplate>, Failure>> getTemplates() => _templates.getAll();
  @override
  Stream<List<WorkoutTemplate>> watchTemplates() => _templates.watchAll();
  @override
  Future<Result<void, Failure>> saveRevision(WorkoutTemplateRevision value) async {
    final existing = await _revisions.getById(value.id);
    if (existing.isError && existing.errorOrNull is! NotFoundFailure) {
      return Result.error(existing.errorOrNull!);
    }
    if (existing.isSuccess && existing.dataOrNull!.status == TemplateRevisionStatus.published) {
      return Result.error(ConflictFailure('Published template revisions are immutable', value.id));
    }
    return _revisions.upsert(value);
  }
  @override
  Future<Result<WorkoutTemplateRevision, Failure>> getRevision(String id) => _revisions.getById(id);
  @override
  Future<Result<List<WorkoutTemplateRevision>, Failure>> getRevisions(String templateId) async {
    final result = await _revisions.getAll();
    return result.map((items) => items.where((item) => item.templateId == templateId).toList()
      ..sort((a, b) => a.revisionNumber.compareTo(b.revisionNumber)));
  }
}
