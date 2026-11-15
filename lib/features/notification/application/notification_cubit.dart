import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growth_gauge/gen/assets.gen.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../settings/config/shared_preferences_config.dart';
import '../domain/notification_settings.dart';
import '../infrastructure/notification_service.dart';
import '../infrastructure/workout_audio_service.dart';
import 'notification_state.dart';

class NotificationCubit({
  required final NotificationService _notificationService,
  WorkoutAudioService? audioService,
}) extends Cubit<NotificationState> {
  final WorkoutAudioService _audioService =
      audioService ?? WorkoutAudioService();

  this : super(const NotificationState()) {
    unawaited(loadNotificationSettings());
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
          sound: settings.soundEnabled ? 'simple_notification' : null,
        );
      } else {
        await _notificationService.cancelNotification(1);
      }
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
      // Explicitly request/verify platform permissions first
      await _notificationService.requestPlatformPermissions();

      final now = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1));
      await _notificationService.scheduleNotification(
        id: 998,
        title: 'Growth Gauge Test Alert',
        body: 'Local notifications are fully operational!',
        scheduledTime: now,
        sound: Assets.sounds.notification.regular,
      );
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
}
