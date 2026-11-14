import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/common/presentation/theme/app_colors.dart';
import 'package:growth_gauge/features/common/presentation/theme/app_typography.dart';
import 'package:growth_gauge/features/notification/infrastructure/notification_service.dart';
import 'package:growth_gauge/features/settings/application/settings_cubit.dart';
import 'package:growth_gauge/features/settings/application/settings_state.dart';
import 'package:growth_gauge/features/settings/config/shared_preferences_config.dart';
import 'package:growth_gauge/features/settings/domain/domain.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNotificationService() extends Mock implements NotificationService {
  TimeOfDay? scheduledTime;

  @override
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? sound,
  }) async {
    scheduledTime = time;
  }
}

class MockLocalAuthentication() extends Mock implements LocalAuthentication {
  Object? biometricError;

  @override
  Future<bool> get canCheckBiometrics async {
    final error = biometricError;
    if (error != null) throw error;
    return false;
  }
}

class MockSecureStorage() extends Mock implements FlutterSecureStorage {
  int deleteAllCallCount = 0;

  @override
  Future<void> deleteAll({
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    deleteAllCallCount++;
  }
}

void main() {
  late SettingsCubit cubit;
  late MockNotificationService notificationService;
  late MockSecureStorage secureStorage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesHelper.init();
    notificationService = MockNotificationService();
    secureStorage = MockSecureStorage();
    cubit = SettingsCubit(
      notificationService: notificationService,
      secureStorage: secureStorage,
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  test('loads settings and marks the initial state ready', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeName', 'midnight');
    await prefs.setString('themeMode', 'dark');
    await prefs.setString('contrastVariant', 'highContrast');
    await prefs.setString('fontSize', 'large');
    await prefs.setString('fontFamilyChoice', 'openDyslexic');
    await prefs.setString('authenticationType', 'pin');
    await prefs.setString('notificationTime', '8:30');
    await cubit.loadSettingsFromStorage();

    expect(cubit.state.isReady, isTrue);
    expect(cubit.state.settings.themeName, AppThemeName.midnight);
    expect(cubit.state.settings.themeMode, ThemeMode.dark);
    expect(
      cubit.state.settings.contrastVariant,
      AppContrastVariant.highContrast,
    );
    expect(cubit.state.settings.fontSize, AppFontSize.large);
    expect(
      cubit.state.settings.fontFamilyChoice,
      AppFontFamilyChoice.openDyslexic,
    );
    expect(cubit.state.settings.authenticationType, AuthenticationType.pin);
    expect(
      cubit.state.settings.notificationTime,
      const TimeOfDay(hour: 8, minute: 30),
    );
  });

  test('appearance changes emit state and persist preferences', () async {
    final emitted = expectLater(
      cubit.stream,
      emits(
        isA<SettingsState>().having(
          (state) => state.settings.themeName,
          'themeName',
          AppThemeName.rust,
        ),
      ),
    );
    cubit.updateThemeName(AppThemeName.rust);
    cubit.updateThemeMode(ThemeMode.light);
    cubit.updateFontSize(AppFontSize.large);
    cubit.updateFontFamilyChoice(AppFontFamilyChoice.manrope);
    await cubit.saveSettingsToStorage();
    await emitted;

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('themeName'), 'rust');
    expect(prefs.getString('themeMode'), 'light');
    expect(prefs.getString('fontSize'), 'large');
    expect(prefs.getString('fontFamilyChoice'), 'manrope');
    expect(prefs.containsKey('exportFormat'), isFalse);
  });

  test(
    'authentication changes persist and disabling clears secure credentials',
    () async {
      await cubit.updateAuthenticationType(AuthenticationType.pin);
      expect(cubit.state.settings.authenticationType, AuthenticationType.pin);
      await cubit.updateAuthenticationType(AuthenticationType.none);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('authenticationType'), 'none');
      expect(secureStorage.deleteAllCallCount, 1);
    },
  );

  test(
    'notification time is saved and scheduled through its service',
    () async {
      await cubit.updateNotificationTime(const TimeOfDay(hour: 7, minute: 45));

      expect(
        cubit.state.settings.notificationTime,
        const TimeOfDay(hour: 7, minute: 45),
      );
      expect(
        notificationService.scheduledTime,
        const TimeOfDay(hour: 7, minute: 45),
      );
    },
  );

  test('biometric availability failures are handled as unavailable', () async {
    final localAuth = MockLocalAuthentication();
    localAuth.biometricError = PlatformException(code: 'unavailable');
    final cubitWithAuth = SettingsCubit(
      notificationService: notificationService,
      localAuth: localAuth,
    );
    addTearDown(cubitWithAuth.close);

    expect(await cubitWithAuth.isBiometricAvailable(), isFalse);
  });

  test('closing the Cubit closes its state stream', () async {
    await cubit.close();

    expect(cubit.isClosed, isTrue);
  });
}
