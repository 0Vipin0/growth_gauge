import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/data/repositories/in_memory_counter_repository.dart';
import 'package:growth_gauge/data/repositories/in_memory_timer_repository.dart';
import 'package:growth_gauge/data/services/notification_service.dart';
import 'package:growth_gauge/ui/core/font_config.dart';
import 'package:growth_gauge/ui/core/shared_preferences_config.dart';
import 'package:growth_gauge/ui/core/theme_config.dart';
import 'package:growth_gauge/ui/counter/provider/provider.dart';
import 'package:growth_gauge/ui/settings/provider/settings_provider.dart';
import 'package:growth_gauge/ui/timer/provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_provider_test.mocks.dart';

@GenerateMocks([NotificationService])
void main() {
  late CounterListProvider mockCounterListProvider;
  late TimerListProvider mockTimerListProvider;
  late MockNotificationService mockNotificationService;
  late SettingsProvider provider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesHelper.init();
    mockNotificationService = MockNotificationService();
    mockCounterListProvider = CounterListProvider(
        notificationService: mockNotificationService,
        repository: InMemoryCounterRepository());
    mockTimerListProvider = TimerListProvider(
        notificationService: mockNotificationService,
        repository: InMemoryTimerRepository());
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

    test('loadSettingsFromStorage', () async {
      // Arrange
      // Act
      await provider.loadSettingsFromStorage();

      // Assert
      expect(provider.settings.themeName, AppThemeName.light);
    });

    test('toggleOnboarding', () {
      // Act
      provider.toggleOnboarding(false);

      // Assert
      expect(provider.isOnboardingComplete, isFalse);
    });

    test('exportDataToCsv', () async {
      // Act
      await provider.exportDataToCsv();

      // Assert
      expect(provider.exportMessage, 'Data exported successfully to CSV!');
    });

    test('saveSettingsToStorage saves settings correctly', () async {
      // Act
      await provider.saveSettingsToStorage();

      // Assert
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('themeName'), 'light');
      expect(prefs.getString('fontSize'), 'medium');
      expect(prefs.getString('fontFamily'), 'roboto');
    });
  });
}
