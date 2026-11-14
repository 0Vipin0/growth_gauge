import 'package:timezone/timezone.dart';

import 'notification_service.dart';

class ProgressSummaryService(final NotificationService _notificationService) {
  // Track last notification timestamp to prevent excessive frequency or duplicate spam
  DateTime? _lastNotificationTimestamp;

  /// Generates a privacy-aware summary based on persisted analytics/session data
  Future<void> sendSmartProgressSummary({
    required int notificationId,
    required int completedWorkoutsThisWeek,
    required int newPersonalRecordsCount,
  }) async {
    // 1. Deduplication Check: Prevent sending more than once every 24 hours
    const cooldownDuration = Duration(hours: 24);
    final now = DateTime.now();
    if (_lastNotificationTimestamp != null &&
        now.difference(_lastNotificationTimestamp!) < cooldownDuration) {
      // Suppress notification to avoid spamming the user
      return;
    }

    // 2. Compose concise, privacy-safe, non-shaming copy
    const String title = 'Weekly Workout Update';
    String body = '';

    if (newPersonalRecordsCount > 0) {
      body =
          'Fantastic progress! You set $newPersonalRecordsCount new personal records recently. Tap to keep the momentum going.';
    } else if (completedWorkoutsThisWeek > 0) {
      body =
          'You have completed $completedWorkoutsThisWeek workouts this week. Consistency builds strength!';
    } else {
      body = 'Ready for your next session? Open Growth Gauge to map your progress today.';
    }

    // 3. Dispatch via notification service
    final scheduledTime = TZDateTime.now(local).add(const Duration(seconds: 1));

    await _notificationService.scheduleNotification(
      id: notificationId,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
    );

    // Update cooldown tracker
    _lastNotificationTimestamp = now;
  }
}
