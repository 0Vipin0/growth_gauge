import 'package:flutter/material.dart';

enum NotificationCategory() {
  general,
  testInstant,
  testDelayed,
  dailyReminder,
  scheduledReminder,
}

extension NotificationCategoryExtension on NotificationCategory {
  String get value => switch (this) {
    NotificationCategory.general => 'general',
    NotificationCategory.testInstant => 'test_instant',
    NotificationCategory.testDelayed => 'test_delayed',
    NotificationCategory.dailyReminder => 'daily_reminder',
    NotificationCategory.scheduledReminder => 'scheduled_reminder',
  };

  String get displayName => switch (this) {
    NotificationCategory.general => 'General',
    NotificationCategory.testInstant => 'Instant Test',
    NotificationCategory.testDelayed => 'Delayed Test',
    NotificationCategory.dailyReminder => 'Daily Reminder',
    NotificationCategory.scheduledReminder => 'Scheduled Reminder',
  };

  static NotificationCategory fromString(String? val) {
    return NotificationCategory.values.firstWhere(
      (e) => e.value == val,
      orElse: () => NotificationCategory.general,
    );
  }
}

enum NotificationStatus() {
  scheduled,
  delivered,
  cancelled,
}

extension NotificationStatusExtension on NotificationStatus {
  String get value => switch (this) {
    NotificationStatus.scheduled => 'scheduled',
    NotificationStatus.delivered => 'delivered',
    NotificationStatus.cancelled => 'cancelled',
  };

  String get displayName => switch (this) {
    NotificationStatus.scheduled => 'Scheduled',
    NotificationStatus.delivered => 'Delivered',
    NotificationStatus.cancelled => 'Cancelled',
  };

  Color get color => switch (this) {
    NotificationStatus.scheduled => Colors.blue,
    NotificationStatus.delivered => Colors.green,
    NotificationStatus.cancelled => Colors.orange,
  };

  static NotificationStatus fromString(String? val) {
    return NotificationStatus.values.firstWhere(
      (e) => e.value == val,
      orElse: () => NotificationStatus.scheduled,
    );
  }
}
