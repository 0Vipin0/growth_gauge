import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:growth_gauge/core/app/app_routes.dart';
import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/core/events/domain_event_dispatcher.dart';
import 'package:growth_gauge/core/routing/app_router.dart';
import 'package:growth_gauge/features/analytics/domain/pr_calculator.dart';
import 'package:growth_gauge/features/analytics/infrastructure/analytics_dao.dart';
import 'package:growth_gauge/features/analytics/projection/analytics_projector.dart';
import 'package:growth_gauge/features/analytics/projection/projection_rebuilder.dart';
import 'package:growth_gauge/features/catalog/infrastructure/exercise_repository.dart';
import 'package:growth_gauge/features/home/launch_route_resolver.dart';
import 'package:growth_gauge/features/notification/infrastructure/notification_service.dart';
import 'package:growth_gauge/features/session/application/session_use_cases.dart';
import 'package:growth_gauge/features/session/infrastructure/session_repository.dart';
import 'package:growth_gauge/features/settings/application/settings_cubit.dart';
import 'package:growth_gauge/features/settings/config/config.dart';
import 'package:growth_gauge/features/settings/model/settings_model.dart';
import 'package:growth_gauge/features/template/infrastructure/template_repository.dart';
import 'package:growth_gauge/features/user/application/user_use_cases.dart';
import 'package:growth_gauge/features/user/infrastructure/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNotificationService() extends Mock implements NotificationService;

void main() {
  late AppDatabase database;
  late GoRouter router;
  late SettingsCubit settingsCubit;
  late DomainEventDispatcher events;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesHelper.init();
    database = AppDatabase.inMemory();
    final sessions = WorkoutSessionRepository(database);
    final exercises = ExerciseRepository(database);
    final templates = TemplateRepository(database);
    events = DomainEventDispatcher();
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
    );
    final routerController = AppRouter(
      initialLocation: appRouteLaunch,
      routes: createAppRoutes(
        database: database,
        exercises: exercises,
        templates: templates,
        sessions: sessions,
        sessionUseCases: sessionUseCases,
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
    settingsCubit = SettingsCubit(
      notificationService: MockNotificationService(),
    );
  });

  tearDown(() async {
    await settingsCubit.close();
    router.dispose();
    await events.dispose();
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
      _AppHarness(router: router, settingsCubit: settingsCubit),
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
    await settingsCubit.updateAuthenticationType(AuthenticationType.pin);
    await tester.pumpWidget(
      _AppHarness(router: router, settingsCubit: settingsCubit),
    );
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, appRoutePinAuth);
    expect(find.text('PIN Authentication'), findsOneWidget);
  });

  testWidgets('pushed app destinations preserve a usable back stack', (
    tester,
  ) async {
    await tester.pumpWidget(
      _AppHarness(router: router, settingsCubit: settingsCubit),
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

  testWidgets('home navigation adapts from bottom bar to width-based rail', (
    tester,
  ) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));
    router.go(appRouteHome);

    await tester.binding.setSurfaceSize(const Size(390, 844));
    await tester.pumpWidget(
      _AppHarness(router: router, settingsCubit: settingsCubit),
    );
    await tester.pumpAndSettle();
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    await tester.tap(
      find.descendant(
        of: find.byType(BottomNavigationBar),
        matching: find.text('Settings'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('App theme'), findsOneWidget);

    await tester.binding.setSurfaceSize(const Size(800, 900));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
      isFalse,
    );
    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).selectedIndex,
      1,
    );

    await tester.binding.setSurfaceSize(const Size(1440, 1000));
    await tester.pumpAndSettle();
    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).extended,
      isTrue,
    );
    expect(
      tester.widget<NavigationRail>(find.byType(NavigationRail)).selectedIndex,
      1,
    );
    expect(tester.takeException(), isNull);
  });
}

class const _AppHarness({
  required final GoRouter router,
  required final SettingsCubit settingsCubit,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<SettingsCubit>.value(
    value: settingsCubit,
    child: MaterialApp.router(routerConfig: router),
  );
}
