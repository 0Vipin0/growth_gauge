import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';
import 'package:growth_gauge/features/analytics/domain/pr_calculator.dart';
import 'package:growth_gauge/features/analytics/infrastructure/analytics_dao.dart';
import 'package:growth_gauge/features/analytics/projection/analytics_projector.dart';
import 'package:growth_gauge/features/analytics/projection/projection_rebuilder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/catalog_seeder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';
import 'package:growth_gauge/features/portability/application/export_data_use_case.dart';
import 'package:growth_gauge/features/portability/application/import_data_use_case.dart';
import 'package:growth_gauge/features/portability/migration/migration_registry.dart';
import 'package:growth_gauge/features/portability/migration/steps/migration_v1_to_v2.dart';
import 'package:growth_gauge/features/portability/migration/steps/migration_v2_to_v3.dart';
import 'package:growth_gauge/features/session/application/session_use_cases.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';
import 'package:growth_gauge/features/template/application/template_use_cases.dart';
import 'package:growth_gauge/features/template/domain/rest_policy.dart';
import 'package:growth_gauge/features/template/domain/target_set.dart';
import 'package:growth_gauge/features/template/domain/template_item.dart';
import 'package:growth_gauge/features/template/domain/workout_block.dart';
import 'package:growth_gauge/features/template/infrastructure/template_repository.dart';

void main() {
  test(
    'workout, analytics, and backup restore retain identical stats',
    () async {
      final database = AppDatabase.inMemory();
      final events = DomainEventDispatcher();
      try {
        final exercises = ExerciseRepository(database);
        await CatalogSeeder(exercises).seedIfEmpty();
        final exercise = (await exercises.findAll()).dataOrNull!.first;
        final templates = TemplateRepository(database);
        final sessions = WorkoutSessionRepository(database);
        final templateUseCases = TemplateUseCases(templates);
        final template = (await templateUseCases.create(
          name: 'Journey workout',
          createdById: 'local-user',
        )).dataOrNull!;
        final revision = (await templates.getRevision(
          template.currentRevisionId!,
        )).dataOrNull!;
        await templateUseCases.updateDraftBlocks(revision.id, [
          WorkoutBlock(
            id: 'journey-block',
            name: 'Main work',
            items: [
              TemplateItem(
                id: 'journey-item',
                exerciseId: exercise.id,
                order: 0,
                targetSets: [
                  for (var index = 1; index <= 4; index++)
                    TargetSet(
                      id: 'target-$index',
                      setNumber: index,
                      targetWeight: 50,
                      targetReps: 8,
                      restPolicy: const RestPolicy(
                        id: 'journey-rest',
                        targetSeconds: 1,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ]);
        await templateUseCases.publish(revision.id);
        final useCases = SessionUseCases(
          templates: templates,
          sessions: sessions,
          events: events,
        );
        var session = (await useCases.createFromRevision(
          revisionId: revision.id,
          userId: 'local-user',
        )).dataOrNull!;
        session = (await useCases.start(session.id)).dataOrNull!;
        for (final set in session.blocks.single.items.single.sets) {
          final recorded = await useCases.recordSet(
            sessionId: session.id,
            setId: set.id,
            weight: 50,
            reps: 8,
          );
          expect(recorded.isSuccess, isTrue);
          if (set.setNumber == 1) {
            final startedRest = await useCases.startRest(
              sessionId: session.id,
              executionSetId: set.id,
            );
            expect(startedRest.isSuccess, isTrue);
            final activeRest = startedRest.dataOrNull!.restIntervals.single;
            final finishedRest = await useCases.finishRest(
              session.id,
              restIntervalId: activeRest.id,
            );
            expect(finishedRest.isSuccess, isTrue);
          }
        }
        session = (await useCases.complete(session.id)).dataOrNull!;

        final projector = AnalyticsProjector(
          db: database,
          prCalculator: const PRCalculator(),
          sessionRepo: sessions,
          exerciseRepo: exercises,
        );
        await projector.project(session);
        final dao = AnalyticsDao(database);
        final before = await dao.getWorkoutHistoryInRange(
          'local-user',
          DateTime.utc(2000),
          DateTime.utc(2100),
        );
        final beforeMetrics = await database
            .select(database.exerciseSetMetrics)
            .get();
        final beforeRecords = await database
            .select(database.personalRecords)
            .get();
        expect(before, hasLength(1));
        expect(before.single.totalCompletedSets, 4);
        expect(beforeMetrics, hasLength(4));
        expect(beforeRecords, isNotEmpty);

        final envelope = await ExportDataUseCase(database: database)();
        final backup = jsonEncode(envelope.toJson());
        await database.transaction(() async {
          await database.delete(database.documents).go();
          await database.delete(database.dailyWorkoutSummaries).go();
          await database.delete(database.exerciseSetMetrics).go();
          await database.delete(database.personalRecords).go();
          await database.delete(database.muscleVolumeBreakdowns).go();
          await database.delete(database.restIntervalMetrics).go();
        });

        final rebuilder = ProjectionRebuilder(
          db: database,
          sessionRepo: sessions,
          projector: projector,
        );
        final importer = ImportDataUseCase(
          database: database,
          migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
          rebuildAnalytics: rebuilder.rebuildAll,
        );
        final report = await importer(backup);
        expect(report.imported, greaterThan(0));

        final after = await dao.getWorkoutHistoryInRange(
          'local-user',
          DateTime.utc(2000),
          DateTime.utc(2100),
        );
        final afterMetrics = await database
            .select(database.exerciseSetMetrics)
            .get();
        final afterRecords = await database
            .select(database.personalRecords)
            .get();
        expect(after, hasLength(1));
        expect(
          after.single.totalCompletedSets,
          before.single.totalCompletedSets,
        );
        expect(
          after.single.totalCompletedReps,
          before.single.totalCompletedReps,
        );
        expect(after.single.volumeLoadKg, before.single.volumeLoadKg);
        expect(afterMetrics, hasLength(beforeMetrics.length));
        expect(
          afterRecords.map((row) => row.prType).toSet(),
          beforeRecords.map((row) => row.prType).toSet(),
        );
        expect((await exercises.findAll()).dataOrNull, isNotEmpty);
        expect((await sessions.listAll()).dataOrNull, hasLength(1));
        await projector.stop();
      } finally {
        await events.dispose();
        await database.close();
      }
    },
  );
}
