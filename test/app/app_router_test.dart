import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:growth_gauge/app/app_routes.dart';
import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/routing/app_router.dart';
import 'package:growth_gauge/features/analytics/domain/pr_calculator.dart';
import 'package:growth_gauge/features/analytics/infrastructure/analytics_dao.dart';
import 'package:growth_gauge/features/analytics/projection/analytics_projector.dart';
import 'package:growth_gauge/features/analytics/projection/projection_rebuilder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';
import 'package:growth_gauge/features/home/launch_route_resolver.dart';
import 'package:growth_gauge/features/notification/infrastructure/notification_service.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';
import 'package:growth_gauge/features/settings/settings.dart';
import 'package:growth_gauge/features/user/application/user_use_cases.dart';
import 'package:growth_gauge/features/user/infrastructure/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNotificationService() extends Mock implements NotificationService;

void main() {
  late AppDatabase database;
  late GoRouter router;
  late SettingsProvider settings;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesHelper.init();
    database = AppDatabase.inMemory();
    final sessions = WorkoutSessionRepository(database);
    final exercises = ExerciseRepository(database);
    final projector = AnalyticsProjector(
      db: database,
      prCalculator: const PRCalculator(),
      sessionRepo: sessions,
      exerciseRepo: exercises,
    );
    final routerController = AppRouter(
      initialLocation: appRouteLaunch,
      routes: createAppRoutes(
        database: database,
        sessions: sessions,
        analyticsDao: AnalyticsDao(database),
        projectionRebuilder: ProjectionRebuilder(
          db: database,
          sessionRepo: sessions,
          projector: projector,
        ),
        userUseCases: UserUseCases(UserRepository(database)),
      ),
    );
    router = routerController.router;
    settings = SettingsProvider(notificationService: MockNotificationService());
  });

  tearDown(() async {
    settings.dispose();
    router.dispose();
    await database.close();
  });

  test('registers stable named locations for application destinations', () {
    expect(router.namedLocation(appRouteNameHome), appRouteHome);
    expect(
      router.namedLocation(appRouteNameExerciseCatalog),
      appRouteExerciseCatalog,
    );
    expect(
      router.namedLocation(appRouteNameBackupRestore),
      appRouteBackupRestore,
    );
  });

  test(
    'launch authentication setting resolves to the expected destination',
    () {
      expect(appRouteForAuthentication(AuthenticationType.none), appRouteHome);
      expect(
        appRouteForAuthentication(AuthenticationType.pin),
        appRoutePinAuth,
      );
      expect(
        appRouteForAuthentication(AuthenticationType.biometric),
        appRouteBiometricAuth,
      );
    },
  );

  testWidgets('unknown destinations show the routing error page', (
    tester,
  ) async {
    await tester.pumpWidget(
      _AppHarness(router: router, database: database, settings: settings),
    );
    router.go('/missing-destination');
    await tester.pumpAndSettle();

    expect(
      find.text('No route defined for /missing-destination'),
      findsOneWidget,
    );
  });

  testWidgets('launch replaces itself with the saved authentication route', (
    tester,
  ) async {
    settings.updateAuthenticationType(AuthenticationType.pin);
    await settings.saveSettingsToStorage();
    await tester.pumpWidget(
      _AppHarness(router: router, database: database, settings: settings),
    );
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, appRoutePinAuth);
    expect(find.text('PIN Authentication'), findsOneWidget);
  });

  testWidgets('pushed app destinations preserve a usable back stack', (
    tester,
  ) async {
    await tester.pumpWidget(
      _AppHarness(router: router, database: database, settings: settings),
    );
    router.go(appRouteHome);
    await tester.pumpAndSettle();
    router.push(appRouteProfile);
    await tester.pumpAndSettle();

    expect(router.canPop(), isTrue);
    router.pop();
    await tester.pumpAndSettle();
    expect(router.routeInformationProvider.value.uri.path, appRouteHome);
  });
}

class const _AppHarness({
  required final GoRouter router,
  required final AppDatabase database,
  required final SettingsProvider settings,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      Provider<AppDatabase>.value(value: database),
      ChangeNotifierProvider<SettingsProvider>.value(value: settings),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}
