import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';
import 'package:growth_gauge/features/catalog/infrastructure/catalog_seeder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';
import 'package:growth_gauge/features/session/application/session_use_cases.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';
import 'package:growth_gauge/features/template/application/template_use_cases.dart';
import 'package:growth_gauge/features/template/domain/rest_policy.dart';
import 'package:growth_gauge/features/template/domain/target_set.dart';
import 'package:growth_gauge/features/template/domain/template_item.dart';
import 'package:growth_gauge/features/template/domain/workout_block.dart';
import 'package:growth_gauge/features/template/domain/workout_template.dart';
import 'package:growth_gauge/features/template/infrastructure/template_repository.dart';
import 'package:growth_gauge/features/template/presentation/template_detail_screen.dart';
import 'package:growth_gauge/features/template/presentation/template_list_screen.dart';

void main() {
  group('TemplateListScreen management', () {
    late AppDatabase database;
    late TemplateRepository templateRepository;
    late TemplateUseCases templateUseCases;
    late ExerciseRepository exerciseRepository;
    late WorkoutSessionRepository sessionRepository;
    late SessionUseCases sessionUseCases;
    late WorkoutTemplate template;
    late GoRouter router;

    setUp(() async {
      database = AppDatabase.inMemory();
      templateRepository = TemplateRepository(database);
      templateUseCases = TemplateUseCases(templateRepository);
      exerciseRepository = ExerciseRepository(database);
      sessionRepository = WorkoutSessionRepository(database);
      sessionUseCases = SessionUseCases(
        templates: templateRepository,
        sessions: sessionRepository,
        events: DomainEventDispatcher(),
      );
      template = (await templateUseCases.create(
        name: 'Management test template',
        createdById: 'user-1',
      )).dataOrNull!;

      router = GoRouter(
        initialLocation: '/templates',
        routes: [
          GoRoute(
            path: '/templates',
            builder: (context, state) => TemplateListScreen(
              repository: templateRepository,
              exerciseRepository: exerciseRepository,
              sessionRepository: sessionRepository,
              sessionUseCases: sessionUseCases,
              useCases: templateUseCases,
              userId: 'user-1',
            ),
          ),
          GoRoute(
            path: '/detail',
            builder: (context, state) => TemplateDetailScreen(
              template: template,
              repository: templateRepository,
              exerciseRepository: exerciseRepository,
              useCases: templateUseCases,
              sessionUseCases: sessionUseCases,
              userId: 'user-1',
            ),
          ),
        ],
      );
    });

    tearDown(() async {
      router.dispose();
      await database.close();
    });

    testWidgets('archives, restores, and permanently deletes a template', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      expect(find.text('Management test template'), findsOneWidget);

      await _chooseMenuAction(tester, 'Archive');
      await tester.pumpAndSettle();
      expect(find.text('Management test template'), findsNothing);

      await tester.tap(find.text('Status: Active'));
      await tester.pumpAndSettle();
      expect(find.text('Management test template'), findsOneWidget);
      expect(
        (await templateRepository.getTemplates()).dataOrNull!.single.isArchived,
        isTrue,
      );

      await _chooseMenuAction(tester, 'Restore');
      await tester.pumpAndSettle();
      expect(find.text('Management test template'), findsNothing);

      await tester.tap(find.text('Status: Archived'));
      await tester.pumpAndSettle();
      expect(find.text('Management test template'), findsOneWidget);
      await _chooseMenuAction(tester, 'Delete permanently');
      await tester.pumpAndSettle();
      expect(find.text('Permanently delete template?'), findsOneWidget);
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();

      expect((await templateRepository.getTemplates()).dataOrNull, isEmpty);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('template details show prescribed set targets', (tester) async {
      await CatalogSeeder(exerciseRepository).seedIfEmpty();
      final revision = (await templateRepository.getRevision(
        template.currentRevisionId!,
      )).dataOrNull!;
      await templateRepository.saveRevision(
        revision.copyWith(
          blocks: [
            const WorkoutBlock(
              id: 'block-main',
              name: 'Main work',
              items: [
                TemplateItem(
                  id: 'item-squat',
                  exerciseId: 'exercise-squat-001',
                  order: 0,
                  targetSets: [
                    TargetSet(
                      id: 'set-squat',
                      setNumber: 1,
                      targetReps: 8,
                      targetWeight: 20,
                      restPolicy: RestPolicy(
                        id: 'rest-squat',
                        targetSeconds: 90,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      router.go('/detail');
      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Main work'));
      await tester.pumpAndSettle();

      expect(find.text('Barbell Back Squat'), findsOneWidget);
      expect(find.text('Set 1 · 8 reps · 20.0 kg · 90s rest'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
    });
  });
}

Future<void> _chooseMenuAction(WidgetTester tester, String action) async {
  await tester.tap(find.byIcon(Icons.more_vert));
  await tester.pumpAndSettle();
  await tester.tap(find.text(action).last);
  await tester.pumpAndSettle();
}
