import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';
import 'package:growth_gauge/features/session/application/session_use_cases.dart';
import 'package:growth_gauge/features/session/domain/session_enums.dart';
import 'package:growth_gauge/features/session/domain/workout_session.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';
import 'package:growth_gauge/features/session/presentation/screens/active_session_screen.dart';
import 'package:growth_gauge/features/template/infrastructure/template_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'active workout configures, skips, pauses and resumes intervals',
    (tester) async {
      final database = AppDatabase.inMemory();
      final events = DomainEventDispatcher();
      final templateRepository = TemplateRepository(database);
      final sessionRepository = WorkoutSessionRepository(database);
      final exerciseRepository = ExerciseRepository(database);
      final useCases = SessionUseCases(
        templates: templateRepository,
        sessions: sessionRepository,
        events: events,
      );
      final now = DateTime.now().toUtc();
      final session = WorkoutSession(
        id: 'active-interval-widget-session',
        userId: 'user-1',
        templateId: 'template-1',
        templateRevisionId: 'revision-1',
        templateName: 'Interval workout',
        status: SessionStatus.inProgress,
        startedAt: now,
        createdAt: now,
      );
      await sessionRepository.save(session);

      await tester.pumpWidget(
        MaterialApp(
          home: ActiveSessionScreen(
            session: session,
            useCases: useCases,
            exerciseRepository: exerciseRepository,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Set up intervals'));
      await tester.pumpAndSettle();
      expect(find.text('Interval timer'), findsOneWidget);
      await tester.enterText(find.byType(TextField).at(0), '2');
      await tester.enterText(find.byType(TextField).at(1), '1');
      await tester.enterText(find.byType(TextField).at(2), '2');
      await tester.enterText(find.byType(TextField).at(3), '1');
      await tester.tap(find.text('Start intervals'));
      await tester.pumpAndSettle();
      expect(find.text('WORK'), findsOneWidget);
      expect(find.text('00:02'), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
      await tester.pump();
      await tester.pump();
      expect(find.text('REST'), findsOneWidget);
      expect(find.text('00:01'), findsOneWidget);

      await tester.tap(find.text('Skip phase'));
      await tester.pumpAndSettle();
      expect(find.text('WORK'), findsOneWidget);

      await tester.tap(find.text('Pause'));
      await tester.pumpAndSettle();
      expect(find.text('PAUSED'), findsOneWidget);
      expect(find.text('Resume'), findsOneWidget);

      await tester.tap(find.text('Resume'));
      await tester.pumpAndSettle();
      expect(find.text('WORK'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
      await events.dispose();
      await database.close();
    },
  );
}
