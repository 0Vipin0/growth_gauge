// main.dart

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'features/counter/chart/chart.dart';
import 'features/counter/counter.dart';
import 'features/settings/settings.dart';
import 'features/timer/chart/chart.dart';
import 'features/timer/timer.dart';
import 'routes.dart';

void main() {
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
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TimerListProvider(
            repository: SharedPreferencesTimerRepository(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => CounterChartProvider()),
        ChangeNotifierProvider(create: (_) => TimerChartProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider(
        counterListProvider:
            Provider.of<CounterListProvider>(context, listen: false),
        timerListProvider:
            Provider.of<TimerListProvider>(context, listen: false),
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
