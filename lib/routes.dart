import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'core/database/app_database.dart';
import 'features/analytics/application/analytics_cubit.dart';
import 'features/analytics/application/analytics_queries.dart';
import 'features/analytics/domain/pr_calculator.dart';
import 'features/analytics/infrastructure/analytics_dao.dart';
import 'features/analytics/presentation/screens/analytics_dashboard_screen.dart';
import 'features/analytics/projection/analytics_projector.dart';
import 'features/analytics/projection/projection_rebuilder.dart';
import 'features/authentication/authentication.dart';
import 'features/catalog/application/catalog_use_cases.dart';
import 'features/catalog/infrastructure/exercise_repository.dart';
import 'features/catalog/presentation/catalog_screen.dart';
import 'features/home/home.dart';
import 'features/onboarding/onboarding.dart';
import 'features/portability/application/export_data_use_case.dart';
import 'features/portability/application/import_data_use_case.dart';
import 'features/portability/application/portability_cubit.dart';
import 'features/portability/infrastructure/file_storage_service.dart';
import 'features/portability/migration/migration_registry.dart';
import 'features/portability/migration/steps/migration_v1_to_v2.dart';
import 'features/portability/migration/steps/migration_v2_to_v3.dart';
import 'features/portability/presentation/screens/backup_restore_screen.dart';
import 'features/session/infrastructure/session_repository.dart';
import 'features/settings/settings.dart';
import 'features/splash/splash.dart';
import 'features/template/application/template_use_cases.dart';
import 'features/template/infrastructure/template_repository.dart';
import 'features/template/presentation/template_list_screen.dart';
import 'features/user/application/goal_cubit.dart';
import 'features/user/application/measurement_cubit.dart';
import 'features/user/application/user_use_cases.dart';
import 'features/user/infrastructure/user_repository.dart';
import 'features/user/presentation/screens/goals_screen.dart';
import 'features/user/presentation/screens/measurements_screen.dart';
import 'features/user/presentation/screens/profile_screen.dart';

mixin AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String biometricAuth = '/biometric_auth';
  static const String pinAuth = '/pin_auth';
  static const String exerciseCatalog = '/exercise_catalog';
  static const String workoutTemplates = '/workout_templates';
  static const String analytics = '/analytics';
  static const String profile = '/profile';
  static const String goals = '/goals';
  static const String measurements = '/measurements';
  static const String backupRestore = '/backup_restore';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    home: (_) => const HomePage(),
    settings: (_) => const SettingsPage(),
    backupRestore: (context) {
      final database = Provider.of<AppDatabase>(context, listen: false);
      final sessions = WorkoutSessionRepository(database);
      final projector = AnalyticsProjector(
        db: database,
        prCalculator: const PRCalculator(),
        sessionRepo: sessions,
        exerciseRepo: ExerciseRepository(database),
      );
      final rebuilder = ProjectionRebuilder(
        db: database,
        sessionRepo: sessions,
        projector: projector,
      );
      return BlocProvider(
        create: (_) => PortabilityCubit(
          exportData: ExportDataUseCase(database: database),
          importData: ImportDataUseCase(
            database: database,
            migrations: MigrationRegistry([
              MigrationV1ToV2(),
              MigrationV2ToV3(),
            ]),
            rebuildAnalytics: rebuilder.rebuildAll,
          ),
          fileStorage: FileStorageService(),
        ),
        child: const BackupRestoreScreen(),
      );
    },
    biometricAuth: (_) => const BiometricAuthScreen(),
    pinAuth: (_) => const PinAuthScreen(),
    exerciseCatalog: (context) {
      final database = Provider.of<AppDatabase>(context, listen: false);
      final repository = ExerciseRepository(database);
      return CatalogScreen(
        repository: repository,
        useCases: CatalogUseCases(repository),
        userId: 'local-user',
      );
    },
    workoutTemplates: (context) {
      final database = Provider.of<AppDatabase>(context, listen: false);
      final repository = TemplateRepository(database);
      return TemplateListScreen(
        repository: repository,
        exerciseRepository: ExerciseRepository(database),
        sessionRepository: WorkoutSessionRepository(database),
        useCases: TemplateUseCases(repository),
        userId: 'local-user',
      );
    },
    analytics: (context) {
      final queries = AnalyticsQueries(
        dao: Provider.of<AnalyticsDao>(context, listen: false),
        rebuilder: Provider.of<ProjectionRebuilder>(context, listen: false),
      );
      return BlocProvider(
        create: (_) {
          final cubit = AnalyticsCubit(queries: queries);
          unawaited(cubit.triggerRebuild());
          return cubit;
        },
        child: const AnalyticsDashboardScreen(),
      );
    },
    profile: (context) {
      final database = Provider.of<AppDatabase>(context, listen: false);
      final repository = UserRepository(database);
      final useCases = UserUseCases(repository);
      return ProfileScreen(useCases: useCases);
    },
    goals: (context) {
      final database = Provider.of<AppDatabase>(context, listen: false);
      final repository = UserRepository(database);
      final useCases = UserUseCases(repository);
      return BlocProvider(
        create: (_) => GoalCubit(useCases: useCases),
        child: const GoalsScreen(),
      );
    },
    measurements: (context) {
      final database = Provider.of<AppDatabase>(context, listen: false);
      final repository = UserRepository(database);
      final useCases = UserUseCases(repository);
      return BlocProvider(
        create: (_) => MeasurementCubit(useCases: useCases),
        child: const MeasurementsScreen(),
      );
    },
  };

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final WidgetBuilder? builder = _routes[routeSettings.name];
    if (builder != null) {
      return PageTransition(
        child: Builder(builder: builder),
        settings: routeSettings,
        type: PageTransitionType.rightToLeftWithFade,
      );
    }
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for ${routeSettings.name}')),
      ),
    );
  }
}
