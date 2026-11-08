import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../features/analytics/domain/pr_calculator.dart';
import '../../features/analytics/infrastructure/analytics_dao.dart';
import '../../features/analytics/projection/analytics_projector.dart';
import '../../features/analytics/projection/projection_rebuilder.dart';
import '../../features/catalog/infrastructure/catalog_seeder.dart';
import '../../features/catalog/infrastructure/exercise_repository.dart';
import '../../features/notification/infrastructure/notification_service.dart';
import '../../features/session/application/session_use_cases.dart';
import '../../features/session/infrastructure/session_repository.dart';
import '../../features/settings/config/shared_preferences_config.dart';
import '../../features/settings/settings.dart';
import '../../features/template/infrastructure/template_repository.dart';
import '../../features/template/infrastructure/template_seeder.dart';
import '../../features/user/application/user_use_cases.dart';
import '../../features/user/infrastructure/user_repository.dart';
import '../database/app_database.dart';
import '../events/domain_event_dispatcher.dart';
import '../routing/app_router.dart';
import 'app_routes.dart';

Future<void> runGrowthGaugeApp({required bool hasCompletedOnboarding}) async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  await notificationService.initializeTimeZone();
  await notificationService.initializeNotificationSettings();
  await SharedPreferencesHelper.init();

  final database = AppDatabase();
  final exercises = ExerciseRepository(database);
  final templates = TemplateRepository(database);

  unawaited(_initializeSeeders(exercises, templates));

  final events = DomainEventDispatcher();
  final sessions = WorkoutSessionRepository(database);
  final sessionUseCases = SessionUseCases(
    templates: templates,
    sessions: sessions,
    events: events,
  );

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

  final String initialRoute = (!hasCompletedOnboarding)
      ? appRouteOnboarding
      : appRouteLaunch;

  final router = AppRouter(
    initialLocation: initialRoute,
    routes: createAppRoutes(
      database: database,
      exercises: exercises,
      templates: templates,
      sessions: sessions,
      sessionUseCases: sessionUseCases,
      analyticsDao: analyticsDao,
      projectionRebuilder: projectionRebuilder,
      userUseCases: userUseCases,
    ),
  ).router;

  final settingsCubit = SettingsCubit(notificationService: notificationService);

  runApp(
    GrowthGaugeRootApp(
      router: router,
      settingsCubit: settingsCubit,
      database: database,
      events: events,
      projector: projector,
    ),
  );
}

Future<void> _initializeSeeders(
  ExerciseRepository exercises,
  TemplateRepository templates,
) async {
  try {
    await CatalogSeeder(exercises).seedOrUpdate();
    await TemplateSeeder(templates).seedOrUpdate();
  } catch (e, st) {
    debugPrint('Error during background database seeding: $e\n$st');
  }
}

class const GrowthGaugeRootApp({
  super.key,
  required final GoRouter router,
  required final SettingsCubit settingsCubit,
  required final AppDatabase database,
  required final DomainEventDispatcher events,
  required final AnalyticsProjector projector,
}) extends StatefulWidget {
  @override
  State<GrowthGaugeRootApp> createState() => _GrowthGaugeRootAppState();
}

class _GrowthGaugeRootAppState() extends State<GrowthGaugeRootApp> {
  @override
  void dispose() {
    widget.router.dispose();
    unawaited(widget.settingsCubit.close());
    unawaited(_disposeServices());
    super.dispose();
  }

  Future<void> _disposeServices() async {
    await widget.projector.stop();
    await widget.events.dispose();
    await widget.database.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Growth Gauge',
      routerConfig: widget.router,
    );
  }
}
