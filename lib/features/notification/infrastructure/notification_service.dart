import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:growth_gauge/gen/assets.gen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../domain/domain.dart';

abstract class NotificationServiceBase() {
  Future<void> initializeTimeZone();
  Future<void> initializeNotificationSettings({
    required Future<void> Function(int id, NotificationStatus status)
    onStatusUpdate,
  });
  Future<void> requestPlatformPermissions();
  Future<void> isAndroidPermissionGranted();
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
    String? sound,
    NotificationCategory type,
  });
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? sound,
  });
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  });
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();
}

class NotificationService() extends NotificationServiceBase {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool notificationsEnabled = false;

  @override
  Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
    final info = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(info.identifier));
  }

  @override
  Future<void> initializeNotificationSettings({
    required Future<void> Function(int id, NotificationStatus status)
    onStatusUpdate,
  }) async {
    await _initializeNotifications(onStatusUpdate);
  }

  Future<void> _initializeNotifications(
    Future<void> Function(int id, NotificationStatus status) onStatusUpdate,
  ) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final WindowsInitializationSettings initializationSettingsWindows =
        WindowsInitializationSettings(
          iconPath: Assets.images.png.icon.path,
          appName: 'Growth Gauge',
          guid: '9b17769e-c5cd-424a-b859-1e8b873909c1',
          appUserModelId: 'Com.GrowthGauge',
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          windows: initializationSettingsWindows,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.id != null) {
          try {
            await onStatusUpdate(response.id!, NotificationStatus.delivered);
          } catch (e) {
            debugPrint('Failed to update log status on response: $e');
          }
        }
      },
    );

    await isAndroidPermissionGranted();
  }

  @override
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
    String? sound,
    NotificationCategory type = NotificationCategory.scheduledReminder,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'growth_gauge_id',
      'growth_gauge_channel',
      channelDescription: 'Growth Gauge Channel for scheduled notifications',
      importance: Importance.max,
      priority: Priority.high,
      sound: sound != null ? RawResourceAndroidNotificationSound(sound) : null,
    );

    final windowsPlatformChannelSpecifics = WindowsNotificationDetails(
      audio: WindowsNotificationAudio.asset(
        sound!,
        fallback: WindowsNotificationSound.reminder,
      ),
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      windows: windowsPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledTime,
      notificationDetails: platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  @override
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? sound,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledTime = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    await scheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      sound: sound,
      type: NotificationCategory.dailyReminder,
    );
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = NotificationDetails(
      android: const AndroidNotificationDetails(
        'growth_gauge_id',
        'growth_gauge_channel',
        channelDescription: 'Growth Gauge Channel for notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      windows: WindowsNotificationDetails(
        audio: WindowsNotificationAudio.preset(
          sound: WindowsNotificationSound.reminder,
        ),
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id: id);
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted =
          await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >()
              ?.areNotificationsEnabled() ??
          false;

      notificationsEnabled = granted;
    }
  }

  @override
  Future<void> requestPlatformPermissions() async {
    await _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      final bool? grantedNotificationPermission = await androidImplementation
          ?.requestNotificationsPermission();
      notificationsEnabled = grantedNotificationPermission ?? false;
    }
  }
}
