import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

class NotificationScheduler(final NotificationService _notificationService) {
  /// Schedules the default daily reminder (1 notification per day)
  Future<void> configureDailyTrainingReminder({
    required TimeOfDay preferredTime,
    bool enabled = true,
  }) async {
    const int dailyReminderId = 888; // Stable identifier for daily reminders

    if (!enabled) {
      // Cancel reminder if disabled by preferences
      await cancelNotification(dailyReminderId);
      return;
    }

    await _notificationService.scheduleDailyNotification(
      id: dailyReminderId,
      title: 'Time to Train!',
      body: 'Consistency is key. Consistency builds your growth gauge. Tap to start today’s session.',
      time: preferredTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    final FlutterLocalNotificationsPlugin plugin =
        FlutterLocalNotificationsPlugin();
    await plugin.cancel(id: id);
  }
}
