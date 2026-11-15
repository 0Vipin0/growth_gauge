import 'package:equatable/equatable.dart';

import '../domain/domain.dart';

class const NotificationState({
  final NotificationSettings settings = const NotificationSettings(),
  final bool isReady = false,
  final String? error,
  final String? message,
  final List<NotificationLog> logs = const [],
  final String? statusFilter,
}) extends Equatable {
  NotificationState copyWith({
    NotificationSettings? settings,
    bool? isReady,
    String? error,
    bool clearError = false,
    String? message,
    bool clearMessage = false,
    Object? logs =
        const _Sentinel(), // Using sentinel to safely allow null or new lists
    String? statusFilter,
    bool clearFilter = false,
  }) {
    return NotificationState(
      settings: settings ?? this.settings,
      isReady: isReady ?? this.isReady,
      error: clearError ? null : error ?? this.error,
      message: clearMessage ? null : message ?? this.message,
      logs: logs is _Sentinel
          ? this.logs
          : (logs! as List<NotificationLog>),
      statusFilter: clearFilter ? null : statusFilter ?? this.statusFilter,
    );
  }

  @override
  List<Object?> get props => [
    settings,
    isReady,
    error,
    message,
    logs,
    statusFilter,
  ];
}

// Internal sentinel class to handle optional list copying cleanly
class const _Sentinel();
