import 'package:equatable/equatable.dart';

import '../domain/domain.dart';

class const NotificationState({
  final NotificationSettings settings = const NotificationSettings(),
  final bool isReady = false,
  final String? error,
  final String? message,
  final List<NotificationLog> logs = const [],
  final NotificationStatus? statusFilter,
}) extends Equatable {
  NotificationState copyWith({
    NotificationSettings? settings,
    bool? isReady,
    String? error,
    bool clearError = false,
    String? message,
    bool clearMessage = false,
    Object? logs = const _Sentinel(),
    NotificationStatus? statusFilter, // Updated to enum type
    bool clearFilter = false,
  }) {
    return NotificationState(
      settings: settings ?? this.settings,
      isReady: isReady ?? this.isReady,
      error: clearError ? null : error ?? this.error,
      message: clearMessage ? null : message ?? this.message,
      logs: logs is _Sentinel ? this.logs : (logs! as List<NotificationLog>),
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

class const _Sentinel();
