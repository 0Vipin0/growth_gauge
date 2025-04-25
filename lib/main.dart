import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:provider/provider.dart';

import 'features/counter/chart/chart.dart';
import 'features/counter/counter.dart';
import 'features/settings/settings.dart';
import 'features/timer/chart/chart.dart';
import 'features/timer/timer.dart';
import 'routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> scheduleNotification({
  required int id,
  required String title,
  required String body,
  required DateTime scheduledTime,
  String? sound,
}) async {
  final androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'growth_gauge_channel',
    'Default Channel',
    channelDescription: 'Channel for default notifications',
    importance: Importance.max,
    priority: Priority.high,
    sound: sound != null ? RawResourceAndroidNotificationSound(sound) : null,
  );

  final platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    scheduledTime,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotifications();
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
