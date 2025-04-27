import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool notificationsEnabled = false;

  Future<void> initializeTimeZone() async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
  }

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      windows: const WindowsInitializationSettings(
        iconPath: 'assets/images/icon.png',
        appName: 'Growth Gauge',
        guid: '9b17769e-c5cd-424a-b859-1e8b873909c1',
        appUserModelId: 'Com.GrowthGauge',
      ),
      linux: LinuxInitializationSettings(
        defaultActionName: 'Open',
        defaultIcon: AssetsLinuxIcon('assets/images/icon.png'),
      ),
      macOS: const DarwinInitializationSettings(),
      iOS: const DarwinInitializationSettings(),
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await isAndroidPermissionGranted();
    await requestPermissions();
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
    String? sound,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'growth_gauge_id',
      'growth_gauge_channel',
      channelDescription: 'Growth Gauge Channel for scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: sound != null
          ? const RawResourceAndroidNotificationSound('simple_notification')
          : null,
    );

    final windowsPlatformChannelSpecifics = WindowsNotificationDetails(
      audio: WindowsNotificationAudio.asset(
        sound!,
        fallback: WindowsNotificationSound.reminder,
      ),
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

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      notificationsEnabled = granted;
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      notificationsEnabled = grantedNotificationPermission ?? false;
    }
  }
}
