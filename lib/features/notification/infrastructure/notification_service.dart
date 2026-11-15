import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:growth_gauge/gen/assets.gen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../core/database/app_database.dart';
import '../domain/domain.dart';

abstract class NotificationServiceBase() {
  Future<void> initializeTimeZone();
  Future<void> initializeNotificationSettings();
  Future<void> requestPlatformPermissions();
  Future<void> isAndroidPermissionGranted();
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
    String? sound,
    String type,
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
}

class NotificationService extends NotificationServiceBase {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AppDatabase _database;
  bool notificationsEnabled = false;

  NotificationService({required AppDatabase database}) : _database = database;

  @override
  Future<void> initializeTimeZone() async {
    tz.initializeTimeZones();
    final info = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(info.identifier));
  }

  @override
  Future<void> initializeNotificationSettings() async {
    await _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
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
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification click interactions here if required
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
    String type = 'scheduled_reminder',
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

    // Persist scheduled notification details into DB logs table
    try {
      await _database
          .into(_database.notificationLogsTable)
          .insert(
            NotificationLogsTableCompanion.insert(
              notificationId: id,
              title: title,
              body: body,
              type: Value(type),
              status: const Value('scheduled'),
              scheduledTime: Value(scheduledTime),
            ),
            mode: InsertMode.insertOrReplace,
          );
    } catch (e) {
      debugPrint('Failed to log scheduled notification: $e');
    }
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
      type: 'daily_reminder',
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

    // Persist immediate/delivered notification log into DB
    try {
      await _database
          .into(_database.notificationLogsTable)
          .insert(
            NotificationLogsTableCompanion.insert(
              notificationId: id,
              title: title,
              body: body,
              type: const Value('instant_alert'),
              status: const Value('delivered'),
              triggeredAt: Value(DateTime.now()),
            ),
            mode: InsertMode.insertOrReplace,
          );
    } catch (e) {
      debugPrint('Failed to log instant notification: $e');
    }
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id: id);

    // Update DB status to cancelled for this notification ID
    try {
      await (_database.update(
        _database.notificationLogsTable,
      )..where((tbl) => tbl.notificationId.equals(id))).write(
        const NotificationLogsTableCompanion(status: Value('cancelled')),
      );
    } catch (e) {
      debugPrint('Failed to update notification cancellation log: $e');
    }
  }

  Future<void> cancelAllPendingNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();

    // Mark all currently scheduled items as cancelled in DB
    try {
      await (_database.update(
        _database.notificationLogsTable,
      )..where((tbl) => tbl.status.equals('scheduled'))).write(
        const NotificationLogsTableCompanion(status: Value('cancelled')),
      );
    } catch (e) {
      debugPrint('Failed to update bulk cancellation logs: $e');
    }
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

  // Add these methods to your NotificationService class:

  Future<List<NotificationLog>> getNotificationLogs({
    String? statusFilter,
  }) async {
    try {
      final query = _database.select(_database.notificationLogsTable);
      if (statusFilter != null && statusFilter != 'all') {
        query.where((tbl) => tbl.status.equals(statusFilter));
      }
      final results = await query.get();

      // Map drift database rows to your Freezed model
      return results.map((row) {
        return NotificationLog(
          id: row.id,
          notificationId: row.notificationId,
          title: row.title,
          body: row.body,
          type: row.type,
          status: row.status,
          scheduledTime:
              row.scheduledTime, // Pass DateTime? directly from Drift row
          triggeredAt: row.triggeredAt,
          createdAt: row.createdAt,
          payload: row.payload,
        );
      }).toList();
    } catch (e) {
      debugPrint('Failed to fetch notification logs: $e');
      return [];
    }
  }
}
