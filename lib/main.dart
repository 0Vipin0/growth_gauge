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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
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
