import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/error/failures.dart';
import 'package:growth_gauge/core/error/result.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';
import 'package:growth_gauge/features/catalog/catalog.dart';
import 'package:growth_gauge/features/session/application/session_use_cases.dart';
import 'package:growth_gauge/features/session/domain/execution_set.dart';
import 'package:growth_gauge/features/session/domain/session_block.dart';
import 'package:growth_gauge/features/session/domain/session_enums.dart';
import 'package:growth_gauge/features/session/domain/session_item.dart';
import 'package:growth_gauge/features/session/domain/workout_session.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';
import 'package:growth_gauge/features/session/presentation/screen/session_summary_screen.dart';
import 'package:growth_gauge/features/template/infrastructure/template_repository.dart';

class FakeExerciseRepository(final Map<String, Exercise> exercises)
    implements IExerciseRepository {
  @override
  Future<Result<Exercise, Failure>> findById(String id) async {
    final ex = exercises[id];
    if (ex != null) {
      return Result.success(ex);
    }
    return Result.error(ValidationFailure('Exercise not found: $id'));
  }

  @override
  Future<Result<List<Exercise>, Failure>> findAll() async =>
      Result.success(exercises.values.toList());

  @override
  Future<Result<void, Failure>> save(Exercise exercise) async =>
      const Result.success(null);

  @override
  Future<Result<List<Exercise>, Failure>> findByStatus(String status) async =>
      Result.success(exercises.values.toList());

  @override
  Future<Result<void, Failure>> delete(String id) async =>
      const Result.success(null);

  @override
  Stream<List<Exercise>> watchAll() => Stream.value(exercises.values.toList());

  @override
  Future<Result<int, Failure>> count() async =>
      Result.success(exercises.length);
}

void main() {
  final now = DateTime.now().toUtc();

  final testExercise = Exercise(
    id: 'exercise-bench-press-001',
    name: 'Barbell Bench Press',
    createdAt: now,
    updatedAt: now,
  );

  final testSession = WorkoutSession(
    id: 'sess-123',
    templateId: 'tmpl-1',
    templateRevisionId: 'rev-1',
    templateName: 'Chest Day',
    userId: 'user-1',
    status: SessionStatus.completed,
    startedAt: now.subtract(const Duration(minutes: 45)),
    completedAt: now,
    blocks: [
      const SessionBlock(
        id: 'block-1',
        items: [
          SessionItem(
            id: 'item-1',
            sourceTemplateItemId: 'src-1',
            exerciseId: 'exercise-bench-press-001',
            order: 0,
            sets: [
              ExecutionSet(
                id: 'set-1',
                setNumber: 1,
                actualReps: 10,
                status: ExecutionSetStatus.completed,
              ),
              ExecutionSet(
                id: 'set-2',
                setNumber: 2,
                actualReps: 12,
                status: ExecutionSetStatus.completed,
              ),
            ],
          ),
          SessionItem(
            id: 'item-2',
            sourceTemplateItemId: 'src-2',
            exerciseId: 'exercise-squat-002',
            order: 1,
            sets: [
              ExecutionSet(
                id: 'set-3',
                setNumber: 1,
                actualReps: 8,
                status: ExecutionSetStatus.completed,
              ),
            ],
          ),
        ],
        sourceTemplateBlockId: '',
        name: '',
      ),
    ],
    createdAt: DateTime.now(),
  );

  group('SessionSummaryScreen', () {
    late AppDatabase database;
    late TemplateRepository templateRepository;
    late WorkoutSessionRepository sessionRepository;
    late SessionUseCases sessionUseCases;
    late DomainEventDispatcher events;

    setUp(() {
      database = AppDatabase.inMemory();
      templateRepository = TemplateRepository(database);
      sessionRepository = WorkoutSessionRepository(database);
      events = DomainEventDispatcher();
      sessionUseCases = SessionUseCases(
        templates: templateRepository,
        sessions: sessionRepository,
        events: events,
      );
    });

    tearDown(() async {
      await events.dispose();
      await database.close();
    });

    testWidgets(
      'resolves exercise names from repository and sums actual reps',
      (tester) async {
        final fakeRepo = FakeExerciseRepository({
          'exercise-bench-press-001': testExercise,
        });

        await tester.pumpWidget(
          MaterialApp(
            home: SessionSummaryScreen(
              session: testSession,
              useCases: sessionUseCases,
              exerciseRepository: fakeRepo,
            ),
          ),
        );

        // Allow async name loading to finish
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('Barbell Bench Press'),
          250,
          scrollable: find
              .descendant(
                of: find.byType(ListView),
                matching: find.byType(Scrollable),
              )
              .first,
        );

        // Resolved exercise name from repository
        expect(find.text('Barbell Bench Press'), findsOneWidget);

        // Fallback formatting for exercise not in repository
        expect(find.text('Squat'), findsOneWidget);

        // Verify actual reps calculation: 10 + 12 = 22 reps for item-1, and 8 reps for item-2
        expect(find.text('22 reps'), findsOneWidget);
        expect(find.text('8 reps'), findsOneWidget);
      },
    );

    testWidgets(
      'uses formatted slug fallback when exerciseRepository is null',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: SessionSummaryScreen(
              session: testSession,
              useCases: sessionUseCases,
            ),
          ),
        );

        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.text('Bench Press'),
          250,
          scrollable: find
              .descendant(
                of: find.byType(ListView),
                matching: find.byType(Scrollable),
              )
              .first,
        );

        // Formatted slugs
        expect(find.text('Bench Press'), findsOneWidget);
        expect(find.text('Squat'), findsOneWidget);
      },
    );
  });
}
