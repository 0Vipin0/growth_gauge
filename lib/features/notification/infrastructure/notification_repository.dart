import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/error/failures.dart';
import '../../../core/error/result.dart';
import '../domain/domain.dart';

/// Abstract contract for notification persistence and log operations.
abstract class INotificationRepository() {
  Future<Result<void, Failure>> insertLog({
    required int notificationId,
    required String title,
    required String body,
    required NotificationCategory type,
    required NotificationStatus status,
    DateTime? scheduledTime,
    DateTime? triggeredAt,
    String? payload,
  });

  Future<Result<List<NotificationLog>, Failure>> getNotificationLogs({
    NotificationStatus? statusFilter,
  });

  Future<Result<void, Failure>> updateLogStatus(
    int logId,
    NotificationStatus newStatus,
  );

  Future<Result<void, Failure>> updateScheduledToCancelled();
}

/// Drift-backed implementation of [INotificationRepository].
class NotificationRepository(AppDatabase db)
    implements INotificationRepository {
  final AppDatabase _database = db;

  @override
  Future<Result<void, Failure>> insertLog({
    required int notificationId,
    required String title,
    required String body,
    required NotificationCategory type,
    required NotificationStatus status,
    DateTime? scheduledTime,
    DateTime? triggeredAt,
    String? payload,
  }) async {
    try {
      await _database
          .into(_database.notificationLogsTable)
          .insert(
            NotificationLogsTableCompanion.insert(
              notificationId: notificationId,
              title: title,
              body: body,
              type: Value(type.value),
              status: Value(status.value),
              scheduledTime: Value(scheduledTime),
              triggeredAt: Value(triggeredAt),
              payload: Value(payload),
            ),
            mode: InsertMode.insertOrReplace,
          );
      return const Result.success(null);
    } catch (e) {
      debugPrint('Failed to insert notification log: $e');
      return Result.error(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<NotificationLog>, Failure>> getNotificationLogs({
    NotificationStatus? statusFilter,
  }) async {
    try {
      final query = _database.select(_database.notificationLogsTable);
      if (statusFilter != null) {
        query.where((tbl) => tbl.status.equals(statusFilter.value));
      }
      final results = await query.get();

      final logs = results.map((row) {
        return NotificationLog(
          id: row.id,
          notificationId: row.notificationId,
          title: row.title,
          body: row.body,
          type: NotificationCategoryExtension.fromString(row.type),
          status: NotificationStatusExtension.fromString(row.status),
          scheduledTime: row.scheduledTime,
          triggeredAt: row.triggeredAt,
          createdAt: row.createdAt,
          payload: row.payload,
        );
      }).toList();

      return Result.success(logs);
    } catch (e) {
      debugPrint('Failed to fetch notification logs: $e');
      return Result.error(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateLogStatus(
    int logId,
    NotificationStatus newStatus,
  ) async {
    try {
      await (_database.update(
        _database.notificationLogsTable,
      )..where((tbl) => tbl.id.equals(logId))).write(
        NotificationLogsTableCompanion(
          status: Value(newStatus.value),
          triggeredAt: newStatus == NotificationStatus.delivered
              ? Value(DateTime.now())
              : const Value.absent(),
        ),
      );
      return const Result.success(null);
    } catch (e) {
      debugPrint('Failed to update log status: $e');
      return Result.error(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> updateScheduledToCancelled() async {
    try {
      await (_database.update(_database.notificationLogsTable)..where(
            (tbl) => tbl.status.equals(NotificationStatus.scheduled.value),
          ))
          .write(
            NotificationLogsTableCompanion(
              status: Value(NotificationStatus.cancelled.value),
            ),
          );
      return const Result.success(null);
    } catch (e) {
      debugPrint('Failed to bulk cancel scheduled logs: $e');
      return Result.error(DatabaseFailure(e.toString()));
    }
  }
}
