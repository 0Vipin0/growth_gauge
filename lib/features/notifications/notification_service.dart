import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      windows: WindowsInitializationSettings(
        appName: 'Growth Gauge',
        guid: '9b17769e-c5cd-424a-b859-1e8b873909c1',
        appUserModelId: 'Com.GrowthGauge',
      ),
      linux: LinuxInitializationSettings(
        defaultActionName: 'Open',
      ),
      macOS: DarwinInitializationSettings(),
      iOS: DarwinInitializationSettings(),
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
    String? sound,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'growth_gauge',
      'Growth Gauge Channel',
      channelDescription: 'Channel for default notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: sound != null ? RawResourceAndroidNotificationSound(sound) : null,
    );

    final windowsPlatformChannelSpecifics = WindowsNotificationDetails(
      audio: WindowsNotificationAudio.asset(sound!),
    );

    final linuxPlatformChannelSpecifics = LinuxNotificationDetails(
      sound: AssetsLinuxSound(sound),
    );

    final macOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: sound,
    );

    final iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: sound,
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      windows: windowsPlatformChannelSpecifics,
      linux: linuxPlatformChannelSpecifics,
      macOS: macOSPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? sound,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledTime: scheduledTime.isBefore(now)
          ? scheduledTime.add(const Duration(days: 1))
          : scheduledTime,
      sound: sound,
    );
  }
}
