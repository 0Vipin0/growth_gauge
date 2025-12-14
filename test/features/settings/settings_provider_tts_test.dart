import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/counter/provider/counter_list_provider.dart';
import 'package:growth_gauge/features/notification/notification_service.dart';
import 'package:growth_gauge/features/settings/config/shared_preferences_config.dart';
import 'package:growth_gauge/features/settings/settings_provider.dart';
import 'package:growth_gauge/features/timer/provider/timer_list_provider.dart';
import 'package:mockito/mockito.dart';

class MockCounterListProvider extends Mock implements CounterListProvider {}

class MockTimerListProvider extends Mock implements TimerListProvider {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  test('SettingsProvider toggles and persists TTS setting', () async {
    await SharedPreferencesHelper.init();
    final provider = SettingsProvider(
        counterListProvider: MockCounterListProvider(),
        timerListProvider: MockTimerListProvider(),
        notificationService: MockNotificationService());

    provider.updateTtsEnabled(false);
    expect(provider.settings.ttsEnabled, false);

    provider.updateTtsEnabled(true);
    expect(provider.settings.ttsEnabled, true);
  });
}
