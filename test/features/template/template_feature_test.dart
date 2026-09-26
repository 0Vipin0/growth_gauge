import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/error/failures.dart';
import 'package:growth_gauge/features/template/application/template_use_cases.dart';
import 'package:growth_gauge/features/template/domain/template_enums.dart';
import 'package:growth_gauge/features/template/domain/workout_block.dart';
import 'package:growth_gauge/features/template/infrastructure/template_repository.dart';

void main() {
  group('Template feature', () {
    late AppDatabase database;
    late TemplateRepository repository;
    late TemplateUseCases useCases;

    setUp(() {
      database = AppDatabase.inMemory();
      repository = TemplateRepository(database);
      useCases = TemplateUseCases(repository);
    });

    tearDown(() async => database.close());

    test('creates a template with its initial draft revision', () async {
      final result =
          await useCases.create(name: 'Upper body', createdById: 'user-1');
      final template = result.dataOrNull!;
      final revision =
          await repository.getRevision(template.currentRevisionId!);

      expect(template.name, 'Upper body');
      expect(revision.dataOrNull!.templateId, template.id);
      expect(revision.dataOrNull!.revisionNumber, 1);
      expect(revision.dataOrNull!.status, TemplateRevisionStatus.draft);
    });

    test('rejects an empty template name', () async {
      final result = await useCases.create(name: '   ', createdById: 'user-1');

      expect(result.errorOrNull, isA<ValidationFailure>());
    });

    test('updates and publishes a draft revision', () async {
      final template =
          (await useCases.create(name: 'Leg day', createdById: 'user-1'))
              .dataOrNull!;
      final revision =
          (await repository.getRevision(template.currentRevisionId!))
              .dataOrNull!;
      const block = WorkoutBlock(id: 'block-1', name: 'Main lifts');

      final updated = await useCases.updateDraftBlocks(revision.id, [block]);
      final published = await useCases.publish(revision.id);
      final savedRevision = await repository.getRevision(revision.id);

      expect(updated.dataOrNull!.blocks, [block]);
      expect(published.isSuccess, isTrue);
      expect(
          savedRevision.dataOrNull!.status, TemplateRevisionStatus.published);
      expect(
          (await repository.getTemplate(template.id))
              .dataOrNull!
              .currentRevisionId,
          revision.id);
    });

    test('published revisions cannot be edited directly or through use cases',
        () async {
      final template =
          (await useCases.create(name: 'Push day', createdById: 'user-1'))
              .dataOrNull!;
      final revision =
          (await repository.getRevision(template.currentRevisionId!))
              .dataOrNull!;
      await useCases.publish(revision.id);

      final directSave = await repository
          .saveRevision(revision.copyWith(changeSummary: 'tampered'));
      final update = await useCases.updateDraftBlocks(
          revision.id, [const WorkoutBlock(id: 'block-1', name: 'Changed')]);

      expect(directSave.errorOrNull, isA<ConflictFailure>());
      expect(update.errorOrNull, isA<ConflictFailure>());
    });

    test(
        'editing a published template creates the next draft and preserves history',
        () async {
      final template =
          (await useCases.create(name: 'Full body', createdById: 'user-1'))
              .dataOrNull!;
      final original =
          (await repository.getRevision(template.currentRevisionId!))
              .dataOrNull!;
      await useCases.publish(original.id);

      final nextDraft = await useCases.createDraftFromCurrent(template.id,
          changeSummary: 'Progression update');
      final revisions = await repository.getRevisions(template.id);

      expect(nextDraft.dataOrNull!.revisionNumber, 2);
      expect(nextDraft.dataOrNull!.status, TemplateRevisionStatus.draft);
      expect(nextDraft.dataOrNull!.changeSummary, 'Progression update');
      expect(revisions.dataOrNull, hasLength(2));
      expect((await repository.getRevision(original.id)).dataOrNull!.status,
          TemplateRevisionStatus.published);
    });
  });
}
