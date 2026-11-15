import 'package:drift/drift.dart';

@DataClassName('NotificationLogData')
class NotificationLogsTable() extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Platform notification identifier (e.g., 1 for daily reminder, 998 for tests)
  IntColumn get notificationId => integer()();

  // Content details
  TextColumn get title => text()();
  TextColumn get body => text()();

  // Classification & State management
  TextColumn get type => text().withDefault(
    const Constant('general'),
  )(); // e.g., 'daily_reminder', 'test_alert', 'workout_cue'
  TextColumn get status => text().withDefault(
    const Constant('scheduled'),
  )(); // 'scheduled', 'delivered', 'cancelled'

  // Timestamps
  DateTimeColumn get scheduledTime => dateTime().nullable()();
  DateTimeColumn get triggeredAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  // Future-proofing payload / extra data (e.g., JSON string for deep linking or metadata)
  TextColumn get payload => text().nullable()();
}
