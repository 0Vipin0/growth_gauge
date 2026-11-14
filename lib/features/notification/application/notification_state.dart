import 'package:equatable/equatable.dart';

import '../domain/notification_settings.dart';

class const NotificationState({
  final NotificationSettings settings = const NotificationSettings(),
  final bool isReady = false,
  final String? error,
}) extends Equatable {
  NotificationState copyWith({
    NotificationSettings? settings,
    bool? isReady,
    String? error,
    bool clearError = false,
  }) {
    return NotificationState(
      settings: settings ?? this.settings,
      isReady: isReady ?? this.isReady,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [settings, isReady, error];
}
