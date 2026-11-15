import 'package:drift/drift.dart';

@DataClassName('NotificationPreferencesData')
class NotificationPreferencesTable() extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Master kill-switches and preferences
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get vibrationEnabled =>
      boolean().withDefault(const Constant(true))();

  // Daily reminder setup (Default: 1 per day)
  BoolColumn get dailyReminderEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get reminderHour =>
      integer().withDefault(const Constant(9))(); // 9:00 AM default
  IntColumn get reminderMinute => integer().withDefault(const Constant(0))();

  // Quiet hours configuration
  BoolColumn get quietHoursEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get quietHoursStartHour => integer().nullable()();
  IntColumn get quietHoursStartMinute => integer().nullable()();
  IntColumn get quietHoursEndHour => integer().nullable()();
  IntColumn get quietHoursEndMinute => integer().nullable()();

  // Motivational style & categorization
  TextColumn get motivationalMessagingStyle =>
      text().withDefault(const Constant('balanced'))();
}
