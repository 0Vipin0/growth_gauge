import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'features/chart/chart.dart';
import 'features/counter/counter.dart';
import 'features/settings/settings.dart';
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
              repository:
                  InMemoryCounterRepository() // or SharedPreferencesCounterRepository()
              ),
        ),
        ChangeNotifierProvider(
          create: (_) => TimerListProvider(
            repository: InMemoryTimerRepository(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => ChartProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final settings = settingsProvider.settings;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Growth Gage App',
            theme: ThemeData(
              primarySwatch: settings.materialThemeColor,
              textTheme: settings.textTheme,
            ),
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
