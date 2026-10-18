import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app/app_routes.dart';
import 'core/database/app_database.dart';
import 'core/events/domain_event_dispatcher.dart';
import 'core/routing/app_router.dart';
import 'features/analytics/domain/pr_calculator.dart';
import 'features/analytics/infrastructure/analytics_dao.dart';
import 'features/analytics/projection/analytics_projector.dart';
import 'features/analytics/projection/projection_rebuilder.dart';
import 'features/catalog/infrastructure/catalog_seeder.dart';
import 'features/catalog/infrastructure/exercise_repository.dart';
import 'features/notification/infrastructure/notification_service.dart';
import 'features/session/infrastructure/session_repository.dart';
import 'features/settings/settings.dart';
import 'features/user/application/user_use_cases.dart';
import 'features/user/infrastructure/user_repository.dart';

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
  final analyticsDao = AnalyticsDao(database);
  final projectionRebuilder = ProjectionRebuilder(
    db: database,
    sessionRepo: sessions,
    projector: projector,
  );
  final userUseCases = UserUseCases(UserRepository(database));
  final router = AppRouter(
    initialLocation: appRouteLaunch,
    routes: createAppRoutes(
      database: database,
      sessions: sessions,
      analyticsDao: analyticsDao,
      projectionRebuilder: projectionRebuilder,
      userUseCases: userUseCases,
    ),
  ).router;
  runApp(
    DependencyProvider(
      database: database,
      events: events,
      projector: projector,
      sessions: sessions,
      analyticsDao: analyticsDao,
      projectionRebuilder: projectionRebuilder,
      userUseCases: userUseCases,
      router: router,
    ),
  );
}

class const DependencyProvider({
  super.key,
  required final AppDatabase database,
  required final DomainEventDispatcher events,
  required final AnalyticsProjector projector,
  required final WorkoutSessionRepository sessions,
  required final AnalyticsDao analyticsDao,
  required final ProjectionRebuilder projectionRebuilder,
  required final UserUseCases userUseCases,
  required final GoRouter router,
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
        Provider<AnalyticsDao>.value(value: analyticsDao),
        Provider<ProjectionRebuilder>.value(value: projectionRebuilder),
        Provider<UserUseCases>.value(value: userUseCases),
        Provider<GoRouter>(
          create: (_) => router,
          dispose: (_, value) => value.dispose(),
        ),
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
      create: (_) => SettingsProvider(notificationService: notificationService),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final ThemeData themeData = settingsProvider.getThemeData();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Growth Gage App',
            theme: themeData,
            routerConfig: context.read<GoRouter>(),
          );
        },
      ),
    );
  }
}
