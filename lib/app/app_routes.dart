import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/database/app_database.dart';
import '../core/routing/app_router.dart';
import '../features/analytics/application/analytics_cubit.dart';
import '../features/analytics/application/analytics_queries.dart';
import '../features/analytics/infrastructure/analytics_dao.dart';
import '../features/analytics/presentation/screens/analytics_dashboard_screen.dart';
import '../features/analytics/projection/projection_rebuilder.dart';
import '../features/authentication/authentication.dart';
import '../features/catalog/application/catalog_use_cases.dart';
import '../features/catalog/infrastructure/exercise_repository.dart';
import '../features/catalog/presentation/catalog_screen.dart';
import '../features/home/fitness_launch_screen.dart';
import '../features/home/home.dart';
import '../features/portability/application/export_data_use_case.dart';
import '../features/portability/application/import_data_use_case.dart';
import '../features/portability/application/portability_cubit.dart';
import '../features/portability/infrastructure/file_storage_service.dart';
import '../features/portability/migration/migration_registry.dart';
import '../features/portability/migration/steps/migration_v1_to_v2.dart';
import '../features/portability/migration/steps/migration_v2_to_v3.dart';
import '../features/portability/presentation/screens/backup_restore_screen.dart';
import '../features/session/application/session_use_cases.dart';
import '../features/session/infrastructure/session_repository.dart';
import '../features/settings/settings_page.dart';
import '../features/template/application/template_use_cases.dart';
import '../features/template/infrastructure/template_repository.dart';
import '../features/template/presentation/template_list_screen.dart';
import '../features/user/application/goal_cubit.dart';
import '../features/user/application/measurement_cubit.dart';
import '../features/user/application/user_use_cases.dart';
import '../features/user/presentation/screens/goals_screen.dart';
import '../features/user/presentation/screens/measurements_screen.dart';
import '../features/user/presentation/screens/profile_screen.dart';

/// Creates application destinations and composes their feature dependencies.
List<RouteBase> createAppRoutes({
  required AppDatabase database,
  required ExerciseRepository exercises,
  required TemplateRepository templates,
  required WorkoutSessionRepository sessions,
  required SessionUseCases sessionUseCases,
  required AnalyticsDao analyticsDao,
  required ProjectionRebuilder projectionRebuilder,
  required UserUseCases userUseCases,
}) {
  final catalogUseCases = CatalogUseCases(exercises);
  final templateUseCases = TemplateUseCases(templates);
  final analyticsQueries = AnalyticsQueries(
    dao: analyticsDao,
    rebuilder: projectionRebuilder,
  );
  final exportData = ExportDataUseCase(database: database);
  final importData = ImportDataUseCase(
    database: database,
    migrations: MigrationRegistry([MigrationV1ToV2(), MigrationV2ToV3()]),
    rebuildAnalytics: projectionRebuilder.rebuildAll,
  );

  return [
    appGoRoute(
      path: appRouteLaunch,
      name: appRouteNameLaunch,
      builder: (_) => const FitnessLaunchScreen(),
    ),
    appGoRoute(
      path: appRouteHome,
      name: appRouteNameHome,
      builder: (_) => HomePage(
        sessionRepository: sessions,
        sessionUseCases: sessionUseCases,
        exerciseRepository: exercises,
      ),
    ),
    appGoRoute(
      path: appRouteSettings,
      name: appRouteNameSettings,
      builder: (_) => const SettingsPage(),
    ),
    appGoRoute(
      path: appRouteBiometricAuth,
      name: appRouteNameBiometricAuth,
      builder: (_) => const BiometricAuthScreen(),
    ),
    appGoRoute(
      path: appRoutePinAuth,
      name: appRouteNamePinAuth,
      builder: (_) => const PinAuthScreen(),
    ),
    appGoRoute(
      path: appRouteExerciseCatalog,
      name: appRouteNameExerciseCatalog,
      builder: (_) => CatalogScreen(
        repository: exercises,
        useCases: catalogUseCases,
        userId: 'local-user',
      ),
    ),
    appGoRoute(
      path: appRouteWorkoutTemplates,
      name: appRouteNameWorkoutTemplates,
      builder: (_) => TemplateListScreen(
        repository: templates,
        exerciseRepository: exercises,
        sessionRepository: sessions,
        sessionUseCases: sessionUseCases,
        useCases: templateUseCases,
        userId: 'local-user',
      ),
    ),
    appGoRoute(
      path: appRouteAnalytics,
      name: appRouteNameAnalytics,
      builder: (_) => BlocProvider(
        create: (_) {
          final cubit = AnalyticsCubit(queries: analyticsQueries);
          unawaited(cubit.triggerRebuild());
          return cubit;
        },
        child: const AnalyticsDashboardScreen(),
      ),
    ),
    appGoRoute(
      path: appRouteProfile,
      name: appRouteNameProfile,
      builder: (_) => ProfileScreen(useCases: userUseCases),
    ),
    appGoRoute(
      path: appRouteGoals,
      name: appRouteNameGoals,
      builder: (_) => BlocProvider(
        create: (_) => GoalCubit(useCases: userUseCases),
        child: const GoalsScreen(),
      ),
    ),
    appGoRoute(
      path: appRouteMeasurements,
      name: appRouteNameMeasurements,
      builder: (_) => BlocProvider(
        create: (_) => MeasurementCubit(useCases: userUseCases),
        child: const MeasurementsScreen(),
      ),
    ),
    appGoRoute(
      path: appRouteBackupRestore,
      name: appRouteNameBackupRestore,
      builder: (_) => BlocProvider(
        create: (_) => PortabilityCubit(
          exportData: exportData,
          importData: importData,
          fileStorage: FileStorageService(),
        ),
        child: const BackupRestoreScreen(),
      ),
    ),
  ];
}
