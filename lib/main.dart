import 'dart:async';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'core/database/app_database.dart';
import 'core/events/domain_event_dispatcher.dart';
import 'features/analytics/domain/pr_calculator.dart';
import 'features/analytics/infrastructure/analytics_dao.dart';
import 'features/analytics/projection/analytics_projector.dart';
import 'features/analytics/projection/projection_rebuilder.dart';
import 'features/catalog/infrastructure/catalog_seeder.dart';
import 'features/catalog/infrastructure/exercise_repository.dart';
import 'features/chart/chart.dart';
import 'features/counter/counter.dart';
import 'features/notification/notification_service.dart';
import 'features/session/infrastructure/session_repository.dart';
import 'features/settings/settings.dart';
import 'features/timer/timer.dart';
import 'routes.dart';

final notificationService = NotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.initializeTimeZone();
  await notificationService.initializeNotificationSettings();
  await SharedPreferencesHelper.init();
  final database = AppDatabase();
  final seedResult = await CatalogSeeder(ExerciseRepository(database))
      .seedIfEmpty();
  if (seedResult.isError) {
    throw StateError(
      'Could not seed exercise catalog: ${seedResult.errorOrNull}',
    );
  }
  final events = DomainEventDispatcher();
  final sessions = WorkoutSessionRepository(database);
  final exercises = ExerciseRepository(database);
  final projector = AnalyticsProjector(
    db: database,
    prCalculator: const PRCalculator(),
    sessionRepo: sessions,
    exerciseRepo: exercises,
  )..start(events);
  runApp(
    DependencyProvider(
      database: database,
      events: events,
      projector: projector,
      sessions: sessions,
    ),
  );
}

class const DependencyProvider({
  super.key,
  required final AppDatabase database,
  required final DomainEventDispatcher events,
  required final AnalyticsProjector projector,
  required final WorkoutSessionRepository sessions,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        Provider<DomainEventDispatcher>(
          create: (_) => events,
          dispose: (_, dispatcher) => unawaited(dispatcher.dispose()),
        ),
        Provider<AnalyticsProjector>(
          create: (_) => projector,
          dispose: (_, analyticsProjector) =>
              unawaited(analyticsProjector.stop()),
        ),
        Provider<WorkoutSessionRepository>.value(value: sessions),
        Provider<AnalyticsDao>(create: (_) => AnalyticsDao(database)),
        Provider<ProjectionRebuilder>(
          create: (_) => ProjectionRebuilder(
            db: database,
            sessionRepo: sessions,
            projector: projector,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CounterListProvider(
            repository: SharedPreferencesCounterRepository(),
            notificationService: notificationService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TimerListProvider(
            repository: SharedPreferencesTimerRepository(),
            notificationService: notificationService,
          ),
        ),
        ChangeNotifierProvider(create: (_) => CounterChartProvider()),
        ChangeNotifierProvider(create: (_) => TimerChartProvider()),
        Provider<NotificationService>.value(value: notificationService),
      ],
      child: const MyApp(),
    );
  }
}

class const MyApp({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider(
        counterListProvider: Provider.of<CounterListProvider>(
          context,
          listen: false,
        ),
        timerListProvider: Provider.of<TimerListProvider>(
          context,
          listen: false,
        ),
        notificationService: notificationService,
      ),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final ThemeData themeData = settingsProvider.getThemeData();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Growth Gage App',
            theme: themeData,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
