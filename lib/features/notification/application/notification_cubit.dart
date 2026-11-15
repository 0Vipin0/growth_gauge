import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growth_gauge/core/database/app_database.dart';
import 'package:growth_gauge/gen/assets.gen.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../settings/config/shared_preferences_config.dart';
import '../domain/domain.dart';
import '../infrastructure/notification_service.dart';
import '../infrastructure/workout_audio_service.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService _notificationService;
  final WorkoutAudioService _audioService;

  NotificationCubit({
    required NotificationService notificationService,
    WorkoutAudioService? audioService,
  }) : _notificationService = notificationService,
       _audioService = audioService ?? WorkoutAudioService(),
       super(const NotificationState()) {
    unawaited(loadNotificationSettings());
    unawaited(loadNotificationLogs());
  }

  Future<void> loadNotificationLogs() async {
    try {
      final List<NotificationLog> logs = await _notificationService
          .getNotificationLogs(statusFilter: state.statusFilter);
      emit(state.copyWith(logs: logs, clearError: true));
    } catch (error) {
      emit(state.copyWith(error: 'Could not load notification logs: $error'));
    }
  }

  Future<void> filterLogsByStatus(String? status) async {
    emit(
      state.copyWith(
        statusFilter: status,
        clearFilter: status == null || status == 'all',
      ),
    );
    try {
      final logs = await _notificationService.getNotificationLogs(
        statusFilter: status,
      );
      emit(state.copyWith(logs: logs));
    } catch (error) {
      emit(state.copyWith(error: 'Could not filter notification logs: $error'));
    }
  }

  /// Manually updates a notification log's status (e.g. marked as delivered or cancelled)
  Future<void> updateLogStatus(int logId, String newStatus) async {
    try {
      await _notificationService.updateLogStatus(logId, newStatus);
      // Explicitly reload and emit new list to guarantee UI updates immediately
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
        type: 'test_delayed',
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
