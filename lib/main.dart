import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import 'data/repositories/drift_activity_repository.dart';
import 'data/repositories/drift_counter_repository.dart';
import 'data/repositories/drift_user_profile_repository.dart';
import 'data/repositories/drift_workout_repository.dart';
import 'data/repositories/shared_preferences_counter_repository.dart';
import 'data/repositories/shared_preferences_timer_repository.dart';
import 'data/repositories/workout_repository.dart';
import 'data/services/flutter_tts_service.dart';
import 'data/services/notification_service.dart';
import 'data/services/persistence/app_database.dart';
import 'data/services/tts_service.dart';
import 'ui/activity/provider/activity_provider.dart';
import 'ui/activity/provider/workout_timer_provider.dart';
import 'ui/chart/provider/counter_chart_provider.dart';
import 'ui/chart/provider/timer_chart_provider.dart';
import 'ui/core/routes.dart';
import 'ui/core/shared_preferences_config.dart';
import 'ui/counter/provider/counter_list_provider.dart';
import 'ui/insights/provider/insights_provider.dart';
import 'ui/profile/provider/user_profile_provider.dart';
import 'ui/settings/provider/settings_provider.dart';
import 'ui/timer/provider/timer_list_provider.dart';
import 'ui/workout/provider/workout_run_provider.dart';
import 'ui/workout/provider/workout_template_provider.dart';

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

  // Migration: Counter List -> Activity List (Drift)
  final driftCounterRepo = DriftCounterRepository(_appDatabase!);
  final existingCounters = await driftCounterRepo.loadCounters();
  if (existingCounters.isEmpty) {
    print('Drift Counter Repository is empty. Checking for legacy data...');
    final sharedPrefsRepo = SharedPreferencesCounterRepository();
    final oldCounters = await sharedPrefsRepo.loadCounters();
    if (oldCounters.isNotEmpty) {
      print(
          'Migrating ${oldCounters.length} counters from SharedPreferences to Drift...');
      await driftCounterRepo.saveCounters(oldCounters);
      print('Migration completed.');
    } else {
      print('No legacy data found.');
    }
  }

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
            repository: DriftCounterRepository(_appDatabase!),
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
        Provider<DriftUserProfileRepository>(
            create: (_) => DriftUserProfileRepository(_appDatabase!)),
        Provider<DriftActivityRepository>(
            create: (_) => DriftActivityRepository(_appDatabase!)),
        Provider<DriftWorkoutRepository>(
            create: (_) => DriftWorkoutRepository(_appDatabase!)),

        ChangeNotifierProvider(
            create: (_) => UserProfileProvider(
                repository: DriftUserProfileRepository(_appDatabase!))),
        ChangeNotifierProvider(
            create: (_) => ActivityProvider(
                repository: DriftActivityRepository(_appDatabase!))),
        ChangeNotifierProvider(
            create: (_) => InsightsProvider(
                repository: DriftActivityRepository(_appDatabase!))),
        ChangeNotifierProvider(
            create: (_) => WorkoutTemplateProvider(
                repository: DriftWorkoutRepository(_appDatabase!))),
        ChangeNotifierProvider(create: (_) => WorkoutTimerProvider()),
        ChangeNotifierProvider(
            create: (_) => WorkoutRunProvider(
                ttsService: FlutterTtsService(FlutterTts()))),
        // Make Workout templates accessible via routes
        Provider<WorkoutRepository>(
            create: (_) => DriftWorkoutRepository(_appDatabase!)),
        Provider<TtsService>(create: (_) => FlutterTtsService(FlutterTts())),
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
