import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growth_gauge/gen/assets.gen.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../settings/config/shared_preferences_config.dart';
import '../domain/domain.dart';
import '../infrastructure/notification_repository.dart';
import '../infrastructure/notification_service.dart';
import '../infrastructure/workout_audio_service.dart';
import 'notification_state.dart';

class NotificationCubit({
  required final NotificationService _notificationService,
  required final INotificationRepository _notificationRepository,
  WorkoutAudioService? audioService,
}) extends Cubit<NotificationState> {
  final WorkoutAudioService _audioService =
      audioService ?? WorkoutAudioService();

  this : super(const NotificationState()) {
    unawaited(loadNotificationSettings());
    unawaited(loadNotificationLogs());
  }

  Future<void> loadNotificationLogs() async {
    try {
      final result = await _notificationRepository.getNotificationLogs(
        statusFilter: state.statusFilter,
      );
      final logs = result.dataOrNull ?? [];
      emit(state.copyWith(logs: logs, clearError: true));
    } catch (error) {
      emit(state.copyWith(error: 'Could not load notification logs: $error'));
    }
  }

  Future<void> filterLogsByStatus(NotificationStatus? status) async {
    emit(state.copyWith(statusFilter: status, clearFilter: status == null));
    try {
      final result = await _notificationRepository.getNotificationLogs(
        statusFilter: status,
      );
      final logs = result.dataOrNull ?? [];
      emit(state.copyWith(logs: logs));
    } catch (error) {
      emit(state.copyWith(error: 'Could not filter notification logs: $error'));
    }
  }

  Future<void> updateLogStatus(int logId, NotificationStatus newStatus) async {
    try {
      await _notificationRepository.updateLogStatus(logId, newStatus);
      await loadNotificationLogs();
    } catch (error) {
      emit(
        state.copyWith(
          error: 'Could not update notification log status: $error',
        ),
      );
    }
  }

  Future<void> updateNotificationSettings(NotificationSettings settings) async {
    emit(state.copyWith(settings: settings, clearError: true));
    await saveNotificationSettings();

    try {
      if (settings.dailyReminderEnabled &&
          settings.notificationsEnabled &&
          settings.notificationTime != null) {
        await _notificationService.scheduleDailyNotification(
          id: 1,
          title: 'Keep the Growth going forever!',
          body: 'Log the items that you have progressed today and keep up the good work!!',
          time: settings.notificationTime!,
          sound: settings.soundEnabled
              ? Assets.sounds.notification.regular
              : null,
        );
      } else {
        await _notificationService.cancelNotification(1);
      }
      await loadNotificationLogs();
    } catch (error) {
      emit(
        state.copyWith(error: 'Could not update notification schedule: $error'),
      );
    }
  }

  Future<void> updateNotificationTime(TimeOfDay time) async {
    await updateNotificationSettings(
      state.settings.copyWith(
        notificationTime: time,
        dailyReminderEnabled: true,
      ),
    );
  }

  Future<void> testAudioCue() async {
    try {
      if (!state.settings.soundEnabled) {
        emit(state.copyWith(error: 'Audio cues are currently disabled.'));
        return;
      }
      _audioService.soundEnabled = state.settings.soundEnabled;
      _audioService.vibrationEnabled = state.settings.vibrationEnabled;
      await _audioService.playRestCompleteCue();
    } catch (error) {
      emit(state.copyWith(error: 'Could not play test audio cue: $error'));
    }
  }

  Future<void> testLocalNotification() async {
    try {
      await _notificationService.requestPlatformPermissions();

      await _notificationService.showNotification(
        id: 998,
        title: 'Growth Gauge Test Alert',
        body: 'Local notifications are fully operational!',
      );
      await loadNotificationLogs();
    } catch (error) {
      emit(state.copyWith(error: 'Could not send test notification: $error'));
    }
  }

  Future<void> loadNotificationSettings() async {
    try {
      final notificationTime = const TimeOfDayConverter().fromJson(
        SharedPreferencesHelper.getNotificationTime(),
      );

      final settings = NotificationSettings(notificationTime: notificationTime);

      if (!isClosed) {
        emit(
          state.copyWith(settings: settings, isReady: true, clearError: true),
        );
      }
    } catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isReady: true,
            error: 'Could not load notification settings: $error',
          ),
        );
      }
    }
  }

  Future<void> saveNotificationSettings() async {
    try {
      final time = const TimeOfDayConverter().toJson(
        state.settings.notificationTime,
      );
      if (time != null) {
        await SharedPreferencesHelper.setNotificationTime(time);
      }
    } catch (error) {
      emit(
        state.copyWith(error: 'Could not save notification settings: $error'),
      );
    }
  }

  Future<void> testDelayedNotification(Duration duration) async {
    try {
      await _notificationService.requestPlatformPermissions();

      final now = tz.TZDateTime.now(tz.local).add(duration);
      await _notificationService.scheduleNotification(
        id: 998,
        title: 'Growth Gauge Test Alert',
        body: 'Local notifications are fully operational!',
        scheduledTime: now,
        sound: Assets.sounds.notification.regular,
        type: NotificationCategory.testDelayed,
      );
      await loadNotificationLogs();
    } catch (error) {
      emit(state.copyWith(error: 'Could not send test notification: $error'));
    }
  }

  Future<void> cancelPendingTestNotification() async {
    try {
      await _notificationService.cancelNotification(998);
      emit(
        state.copyWith(
          clearError: true,
          message: 'Cancelled pending test notification (Title: Growth Gauge Test Alert)',
        ),
      );
      emit(state.copyWith(clearMessage: true));
      await loadNotificationLogs();
    } catch (error) {
      emit(
        state.copyWith(
          error: 'Could not cancel pending notification: $error',
          clearMessage: true,
        ),
      );
    }
  }
}
