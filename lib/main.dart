import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'features/chart/chart.dart';
import 'features/counter/counter.dart';
import 'features/notification/notification_service.dart';
import 'features/settings/settings.dart';
import 'features/profile/provider/user_profile_provider.dart';
import 'features/activity/activity.dart';
import 'features/insights/insights.dart';
import 'features/workout/provider/workout_template_provider.dart';
import 'features/workout/widgets/workout_templates_page.dart';
import 'features/workout/provider/workout_run_provider.dart';
import 'features/workout/services/flutter_tts_service.dart';
import 'features/workout/services/tts_service.dart';
import 'features/timer/timer.dart';
import 'data/services/persistence/app_database.dart';
import 'data/repositories/drift_user_profile_repository.dart';
import 'data/repositories/drift_activity_repository.dart';
import 'data/repositories/drift_workout_repository.dart';
import 'data/repositories/workout_repository.dart';
import 'routes.dart';

final notificationService = NotificationService();

// Database instance will be created in main()
AppDatabase? _appDatabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.initializeTimeZone();
  await notificationService.initializeNotificationSettings();
  await SharedPreferencesHelper.init();

  // Initialize local DB
  _appDatabase = await AppDatabase.open();

  runApp(const DependencyProvider());
}

class DependencyProvider extends StatelessWidget {
  const DependencyProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
        // Repositories backed by Drift DB
        Provider<AppDatabase>.value(value: _appDatabase!),
        Provider<DriftUserProfileRepository>(create: (_) => DriftUserProfileRepository(_appDatabase!)),
        Provider<DriftActivityRepository>(create: (_) => DriftActivityRepository(_appDatabase!)),
        Provider<DriftWorkoutRepository>(create: (_) => DriftWorkoutRepository(_appDatabase!)),

        ChangeNotifierProvider(create: (_) => UserProfileProvider(repository: DriftUserProfileRepository(_appDatabase!))),
        ChangeNotifierProvider(create: (_) => ActivityProvider(repository: DriftActivityRepository(_appDatabase!))),
        ChangeNotifierProvider(create: (_) => InsightsProvider(repository: DriftActivityRepository(_appDatabase!))),
        ChangeNotifierProvider(create: (_) => WorkoutTemplateProvider(repository: DriftWorkoutRepository(_appDatabase!))),
        ChangeNotifierProvider(create: (_) => WorkoutTimerProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutRunProvider(ttsService: FlutterTtsService())),
        // Make Workout templates accessible via routes
        Provider<WorkoutRepository>(create: (_) => DriftWorkoutRepository(_appDatabase!)),
        Provider<TtsService>(create: (_) => FlutterTtsService()),
        Provider<NotificationService>.value(value: notificationService),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
