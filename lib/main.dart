import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/app/app_routes.dart';
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
import 'features/session/application/session_use_cases.dart';
import 'features/session/infrastructure/session_repository.dart';
import 'features/settings/settings.dart';
import 'features/template/infrastructure/template_repository.dart';
import 'features/template/infrastructure/template_seeder.dart';
import 'features/user/application/user_use_cases.dart';
import 'features/user/infrastructure/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  await notificationService.initializeTimeZone();
  await notificationService.initializeNotificationSettings();
  await SharedPreferencesHelper.init();

  final database = AppDatabase();
  final exercises = ExerciseRepository(database);
  final templates = TemplateRepository(database);

  // Run seeders in the background without throwing errors that halt app startup
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
  final router = AppRouter(
    initialLocation: appRouteLaunch,
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
    GrowthGaugeApp(
      router: router,
      settingsCubit: settingsCubit,
      database: database,
      events: events,
      projector: projector,
    ),
  );
}

/// Safely runs database seeders in the background so application startup never blocks or crashes.
Future<void> _initializeSeeders(
  ExerciseRepository exercises,
  TemplateRepository templates,
) async {
  try {
    final catalogSeedResult = await CatalogSeeder(exercises).seedIfEmpty();
    if (catalogSeedResult.isError) {
      debugPrint(
        'Warning: Could not seed exercise catalog: ${catalogSeedResult.errorOrNull}',
      );
    }

    final templateSeedResult = await TemplateSeeder(templates).seedIfEmpty();
    if (templateSeedResult.isError) {
      debugPrint(
        'Warning: Could not seed workout templates: ${templateSeedResult.errorOrNull}',
      );
    }
  } catch (e, st) {
    debugPrint('Error during background database seeding: $e\n$st');
  }
}

class const GrowthGaugeApp({
  super.key,
  required final GoRouter router,
  required final SettingsCubit settingsCubit,
  required final AppDatabase database,
  required final DomainEventDispatcher events,
  required final AnalyticsProjector projector,
}) extends StatefulWidget {
  @override
  State<GrowthGaugeApp> createState() => _GrowthGaugeAppState();
}

class _GrowthGaugeAppState() extends State<GrowthGaugeApp> {
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
    return BlocProvider<SettingsCubit>.value(
      value: widget.settingsCubit,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Growth Gage App',
          theme: state.settings.appTheme.getThemeData(),
          routerConfig: widget.router,
        ),
      ),
    );
  }
}
