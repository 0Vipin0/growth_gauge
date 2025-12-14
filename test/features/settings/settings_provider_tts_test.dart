import 'package:flutter_test/flutter_test.dart';
import 'package:growth_gauge/features/settings/settings_provider.dart';
import 'package:growth_gauge/features/settings/config/shared_preferences_config.dart';

void main() {
  test('SettingsProvider toggles and persists TTS setting', () async {
    await SharedPreferencesHelper.init();
    final provider = SettingsProvider(counterListProvider: throw UnimplementedError(), timerListProvider: throw UnimplementedError(), notificationService: throw UnimplementedError());

    provider.updateTtsEnabled(false);
    expect(provider.settings.ttsEnabled, false);

    provider.updateTtsEnabled(true);
    expect(provider.settings.ttsEnabled, true);
  });
}
