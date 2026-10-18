import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/notification/infrastructure/notification_service.dart';
import 'package:growth_gauge/features/settings/config/config.dart';
import 'package:growth_gauge/features/settings/model/model.dart';
import 'package:growth_gauge/features/settings/settings_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNotificationService() extends Mock implements NotificationService;

void main() {
  late SettingsProvider provider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesHelper.init();
    provider = SettingsProvider(notificationService: MockNotificationService());
  });

  test('updates the selected theme and notifies listeners', () {
    var notifications = 0;
    provider.addListener(() => notifications++);

    provider.updateThemeName(AppThemeName.darkHighContrast);

    expect(provider.settings.themeName, AppThemeName.darkHighContrast);
    expect(notifications, 1);
  });

  test('loads saved appearance and authentication settings', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeName', 'lightHighContrast');
    await prefs.setString('fontSize', 'large');
    await prefs.setString('fontFamily', 'roboto');
    await prefs.setString('authenticationType', 'pin');
    await provider.loadSettingsFromStorage();

    expect(provider.settings.themeName, AppThemeName.lightHighContrast);
    expect(provider.settings.fontSize, AppFontSize.large);
    expect(provider.settings.authenticationType, AuthenticationType.pin);
  });

  test('saves appearance and authentication settings', () async {
    provider.updateThemeName(AppThemeName.dark);
    provider.updateFontSize(AppFontSize.large);
    provider.updateFontFamily(AppFontFamily.roboto);
    provider.updateAuthenticationType(AuthenticationType.pin);
    await provider.saveSettingsToStorage();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('themeName'), 'dark');
    expect(prefs.getString('fontSize'), 'large');
    expect(prefs.getString('fontFamily'), 'roboto');
    expect(prefs.getString('authenticationType'), 'pin');
    expect(prefs.containsKey('exportFormat'), isFalse);
  });
}
