import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'features/chart/chart.dart';
import 'features/counter/counter.dart';
import 'features/notification/notification_service.dart';
import 'features/settings/settings.dart';
import 'features/timer/timer.dart';
import 'routes.dart';

final notificationService = NotificationService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.initializeTimeZone();
  await notificationService.initializeNotificationSettings();
  await SharedPreferencesHelper.init();
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
