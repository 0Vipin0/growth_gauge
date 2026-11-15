import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_log.freezed.dart';
part 'notification_log.g.dart';

@freezed
abstract class NotificationLog with _$NotificationLog {
  const factory({
    required int id,
    required int notificationId,
    required String title,
    required String body,
    @Default('general') String type,
    @Default('scheduled') String status,
    DateTime? scheduledTime,
    DateTime? triggeredAt,
    required DateTime createdAt,
    String? payload,
  }) = _NotificationLog;

  factory fromJson(Map<String, dynamic> json) =>
      _$NotificationLogFromJson(json);
}
