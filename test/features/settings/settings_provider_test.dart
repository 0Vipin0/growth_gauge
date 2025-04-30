import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/counter/model/model.dart';
import 'package:growth_gauge/features/counter/provider/counter_list_provider.dart';
import 'package:growth_gauge/features/notification/notification_service.dart';
import 'package:growth_gauge/features/settings/config/config.dart';
import 'package:growth_gauge/features/settings/settings_provider.dart';
import 'package:growth_gauge/features/timer/model/model.dart';
import 'package:growth_gauge/features/timer/provider/timer_list_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../counter/provider/counter_list_provider_test.dart';
import '../timer/provider/timer_list_provider_test.dart';

class MockCounterListProvider extends Mock implements CounterListProvider {}
class MockTimerListProvider extends Mock implements TimerListProvider {}
class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockCounterListProvider mockCounterListProvider;
  late MockTimerListProvider mockTimerListProvider;
  late MockNotificationService mockNotificationService;
  late SettingsProvider provider;

  setUp(() async {
    mockCounterListProvider = MockCounterListProvider();
    mockTimerListProvider = MockTimerListProvider();
    mockNotificationService = MockNotificationService();
    provider = SettingsProvider(
      counterListProvider: mockCounterListProvider,
      timerListProvider: mockTimerListProvider,
      notificationService: mockNotificationService,
    );

    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesHelper.init();

    when(mockCounterListProvider.counters).thenReturn(<CounterModel>[]);
    when(mockTimerListProvider.timers).thenReturn(<TimerModel>[]);
    when(mockCounterListProvider.importCountersFromData(testCounters)).thenAnswer((_) => Future.value());
    when(mockTimerListProvider.importTimersFromData(testTimers)).thenAnswer((_) => Future.value());
  });

  group('SettingsProvider Tests', () {
    test('updateThemeName updates the theme and notifies listeners', () {
      // Act
      provider.updateThemeName(AppThemeName.dark);

      // Assert
      expect(provider.settings.themeName, AppThemeName.dark);
    });

    test('updateFontSize updates the font size and notifies listeners', () {
      // Act
      provider.updateFontSize(AppFontSize.large);

      // Assert
      expect(provider.settings.fontSize, AppFontSize.large);
    });

    test('updateFontFamily updates the font family and notifies listeners', () {
      // Act
      provider.updateFontFamily(AppFontFamily.roboto);

      // Assert
      expect(provider.settings.fontFamily, AppFontFamily.roboto);
    });

    test('updateNotificationTime schedules a notification and updates settings', () {
      // Arrange
      const time = TimeOfDay(hour: 8, minute: 30);

      // Act
      provider.updateNotificationTime(time);

      // Assert
      verify(mockNotificationService.scheduleDailyNotification(
        id: 1,
        title: 'Daily Notification',
        body: 'This is a notification body',
        time: time,
        sound: anyNamed('sound'),
      )).called(1);
      expect(provider.settings.notificationTime, time);
    });

    // Add more tests for other methods

    test('updateThemeName', () {
      // TODO: Add test logic for updateThemeName
    });

    test('updateFontSize', () {
      // TODO: Add test logic for updateFontSize
    });

    test('updateFontFamily', () {
      // TODO: Add test logic for updateFontFamily
    });

    test('updateNotificationTime', () {
      // TODO: Add test logic for updateNotificationTime
    });

    test('loadSettingsFromStorage', () async {
      // Arrange
      when(mockCounterListProvider.counters).thenReturn([]);
      when(mockTimerListProvider.timers).thenReturn([]);

      // Act
      await provider.loadSettingsFromStorage();

      // Assert
      expect(provider.settings.themeName, AppThemeName.light);
    });

    test('saveSettingsToStorage', () async {
      // Act
      await provider.saveSettingsToStorage();

      // Assert
      verify(mockCounterListProvider.counters).called(1);
    });

    test('exportData', () async {
      // Arrange
      when(mockCounterListProvider.counters).thenReturn([]);
      when(mockTimerListProvider.timers).thenReturn([]);

      // Act
      await provider.exportData();

      // Assert
      expect(provider.exportMessage, contains('successfully'));
    });

    test('importData', () async {
      // Arrange
      when(mockCounterListProvider.importCountersFromData(testCounters)).thenReturn(null);
      when(mockTimerListProvider.importTimersFromData(testTimers)).thenReturn(null);

      // Act
      await provider.importData();

      // Assert
      expect(provider.importMessage, contains('successfully'));
    });

    test('toggleOnboarding', () {
      // Act
      provider.toggleOnboarding();

      // Assert
      expect(provider.settings.hasCompletedOnboarding, isFalse);
    });

    test('exportDataToCsv', () async {
      // Act
      final csvData = await provider.exportDataToCsv();

      // Assert
      expect(csvData, contains('Counter Name,Count,Description'));
    });

    test('clearAppData', () async {
      // Act
      await provider.clearAppData();

      // Assert
      expect(provider.settings.themeName, AppThemeName.light);
      expect(provider.settings.fontSize, AppFontSize.medium);
      expect(provider.settings.fontFamily, AppFontFamily.defaultFont);
    });

    test('isBiometricAvailable', () async {
      // Arrange
      when(mockNotificationService.isBiometricAvailable()).thenAnswer((_) async => true);

      // Act
      final isAvailable = await provider.isBiometricAvailable();

      // Assert
      expect(isAvailable, isTrue);
    });
  });
}
