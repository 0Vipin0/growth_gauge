import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/analytics/analytics.dart';
import '../../features/authentication/authentication.dart';
import '../../features/catalog/catalog.dart';
import '../../features/home/fitness_launch_screen.dart';
import '../../features/home/home.dart';
import '../../features/portability/migration/steps/migration_v1_to_v2.dart';
import '../../features/portability/migration/steps/migration_v2_to_v3.dart';
import '../../features/portability/portability.dart';
import '../../features/session/session.dart';
import '../../features/settings/settings.dart';
import '../../features/template/template.dart';
import '../../features/user/user.dart';
import '../database/app_database.dart';
import '../routing/app_router.dart';

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
      builder: (_, _) => const FitnessLaunchScreen(),
    ),
    appGoRoute(
      path: appRouteHome,
      name: appRouteNameHome,
      builder: (_, _) => StreamBuilder<List<DailyWorkoutSummary>>(
        stream: analyticsQueries.watchWorkoutHistory('local-user'),
        builder: (context, snapshot) {
          final workoutHistory = snapshot.data ?? [];
          return HomePage(
            sessionRepository: sessions,
            sessionUseCases: sessionUseCases,
            exerciseRepository: exercises,
            templateRepository: templates,
            workoutHistory: workoutHistory,
          );
        },
      ),
    ),
    appGoRoute(
      path: appRouteSettings,
      name: appRouteNameSettings,
      builder: (_, _) => const SettingsPage(),
    ),
    appGoRoute(
      path: appRouteBiometricAuth,
      name: appRouteNameBiometricAuth,
      builder: (_, _) => const BiometricAuthScreen(),
    ),
    appGoRoute(
      path: appRoutePinAuth,
      name: appRouteNamePinAuth,
      builder: (_, _) => const PinAuthScreen(),
    ),
    appGoRoute(
      path: appRouteExerciseCatalog,
      name: appRouteNameExerciseCatalog,
      builder: (_, _) => CatalogScreen(
        repository: exercises,
        useCases: catalogUseCases,
        userId: 'local-user',
      ),
    ),
    appGoRoute(
      path: appRouteWorkoutTemplates,
      name: appRouteNameWorkoutTemplates,
      builder: (_, _) => TemplateListScreen(
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
      builder: (_, _) => BlocProvider(
        create: (_) {
          final cubit = AnalyticsCubit(queries: analyticsQueries);
          unawaited(cubit.triggerRebuild());
          return cubit;
        },
        child: AnalyticsDashboardScreen(
          sessionRepository: sessions,
          userId: 'local-user',
        ),
      ),
    ),
    appGoRoute(
      path: appRouteProfile,
      name: appRouteNameProfile,
      builder: (_, _) => ProfileScreen(useCases: userUseCases),
    ),
    appGoRoute(
      path: appRouteGoals,
      name: appRouteNameGoals,
      builder: (_, _) => BlocProvider(
        create: (_) => GoalCubit(useCases: userUseCases),
        child: const GoalsScreen(),
      ),
    ),
    appGoRoute(
      path: appRouteMeasurements,
      name: appRouteNameMeasurements,
      builder: (_, _) => BlocProvider(
        create: (_) => MeasurementCubit(useCases: userUseCases),
        child: const MeasurementsScreen(),
      ),
    ),
    appGoRoute(
      path: appRouteBackupRestore,
      name: appRouteNameBackupRestore,
      builder: (_, _) => BlocProvider(
        create: (_) => PortabilityCubit(
          exportData: exportData,
          importData: importData,
          fileStorage: FileStorageService(),
        ),
        child: const BackupRestoreScreen(),
      ),
    ),
    appGoRoute(
      path: appRouteActiveSession,
      name: appRouteNameActiveSession,
      builder: (_, state) {
        final session = state.extra! as WorkoutSession;
        return ActiveSessionScreen(
          session: session,
          useCases: sessionUseCases,
          exerciseRepository: exercises,
        );
      },
    ),
    appGoRoute(
      path: appRouteSessionSummary,
      name: appRouteNameSessionSummary,
      builder: (_, state) {
        final session = state.extra! as WorkoutSession;
        return SessionSummaryScreen(session: session);
      },
    ),
    appGoRoute(
      path: appRoutePrTrophies,
      name: appRouteNamePrTrophies,
      builder: (_, state) {
        final cubit = state.extra as AnalyticsCubit?;
        return BlocProvider.value(
          value: cubit ?? AnalyticsCubit(queries: analyticsQueries),
          child: const PrTrophyScreen(),
        );
      },
    ),
    appGoRoute(
      path: appRouteExerciseProgression,
      name: appRouteNameExerciseProgression,
      builder: (_, state) {
        final extra = state.extra;
        final AnalyticsCubit cubit;
        String? initialExerciseId;
        if (extra is AnalyticsCubit) {
          cubit = extra;
        } else if (extra is Map) {
          cubit =
              extra['cubit'] as AnalyticsCubit? ??
              AnalyticsCubit(queries: analyticsQueries);
          initialExerciseId = extra['initialExerciseId'] as String?;
        } else {
          cubit = AnalyticsCubit(queries: analyticsQueries);
        }
        return BlocProvider.value(
          value: cubit,
          child: ExerciseProgressionScreen(
            sessionRepository: sessions,
            exerciseRepository: exercises,
            initialExerciseId: initialExerciseId,
          ),
        );
      },
    ),
    appGoRoute(
      path: appRouteCustomExercise,
      name: appRouteNameCustomExercise,
      builder: (_, _) =>
          CustomExerciseScreen(useCases: catalogUseCases, userId: 'local-user'),
    ),
    appGoRoute(
      path: appRouteExerciseDetail,
      name: appRouteNameExerciseDetail,
      builder: (_, state) {
        final exercise = state.extra! as Exercise;
        return ExerciseDetailScreen(
          exercise: exercise,
          repository: exercises,
          useCases: catalogUseCases,
          userId: 'local-user',
        );
      },
    ),
    appGoRoute(
      path: appRouteTemplateDetail,
      name: appRouteNameTemplateDetail,
      builder: (_, state) {
        final template = state.extra! as WorkoutTemplate;
        return TemplateDetailScreen(
          template: template,
          repository: templates,
          exerciseRepository: exercises,
          useCases: templateUseCases,
          sessionUseCases: sessionUseCases,
          userId: 'local-user',
        );
      },
    ),
    appGoRoute(
      path: appRouteTemplateEditor,
      name: appRouteNameTemplateEditor,
      builder: (_, state) {
        final revision = state.extra! as WorkoutTemplateRevision;
        return TemplateEditorScreen(
          revision: revision,
          repository: templates,
          exerciseRepository: exercises,
          useCases: templateUseCases,
          userId: 'local-user',
        );
      },
    ),
  ];
}
