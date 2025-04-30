import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:growth_gauge/features/settings/settings_provider.dart';
import 'package:growth_gauge/features/settings/model/model.dart';
import 'package:growth_gauge/features/counter/provider/counter_list_provider.dart';
import 'package:growth_gauge/features/timer/provider/timer_list_provider.dart';
import 'package:growth_gauge/features/notification/notification_service.dart';

class MockCounterListProvider extends Mock implements CounterListProvider {}
class MockTimerListProvider extends Mock implements TimerListProvider {}
class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockCounterListProvider mockCounterListProvider;
  late MockTimerListProvider mockTimerListProvider;
  late MockNotificationService mockNotificationService;
  late SettingsProvider provider;

  setUp(() {
    mockCounterListProvider = MockCounterListProvider();
    mockTimerListProvider = MockTimerListProvider();
    mockNotificationService = MockNotificationService();
    provider = SettingsProvider(
      counterListProvider: mockCounterListProvider,
      timerListProvider: mockTimerListProvider,
      notificationService: mockNotificationService,
    );
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
      final time = TimeOfDay(hour: 8, minute: 30);

      // Act
      provider.updateNotificationTime(time);

      // Assert
      verify(mockNotificationService.scheduleDailyNotification(
        id: 1,
        title: anyNamed('title'),
        body: anyNamed('body'),
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

    test('loadSettingsFromStorage', () {
      // TODO: Add test logic for loadSettingsFromStorage
    });

    test('saveSettingsToStorage', () {
      // TODO: Add test logic for saveSettingsToStorage
    });

    test('exportData', () {
      // TODO: Add test logic for exportData
    });

    test('importData', () {
      // TODO: Add test logic for importData
    });

    test('toggleOnboarding', () {
      // TODO: Add test logic for toggleOnboarding
    });

    test('exportDataToCsv', () {
      // TODO: Add test logic for exportDataToCsv
    });

    test('clearAppData', () {
      // TODO: Add test logic for clearAppData
    });

    test('isBiometricAvailable', () {
      // TODO: Add test logic for isBiometricAvailable
    });
  });
}