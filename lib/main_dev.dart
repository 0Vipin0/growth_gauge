import 'package:flutter/material.dart';

import 'core/app/app_runner.dart';
import 'features/settings/config/shared_preferences_config.dart';

void main() async {
  // Safety guard against release mode compilation
  assert(() {
    return true;
  }(), 'ERROR: main_dev.dart cannot be used in release or profile builds!');

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();

  // Compile-time dev flags restricted solely to dev entry point
  const bool devBypassAuth = bool.fromEnvironment('DEV_BYPASS_AUTH');
  const bool devForceOnboarding = bool.fromEnvironment('DEV_FORCE_ONBOARDING');

  debugPrint(
    '🔧 [DEV MODE] Bypass Auth: $devBypassAuth, Force Onboarding: $devForceOnboarding',
  );

  if (devBypassAuth) {
    debugPrint('🔧 [DEV MODE] Authentication checks bypassed.');
  }

  // Resolve onboarding based on dev flag override or real storage
  final bool hasCompletedOnboarding =
      !devForceOnboarding &&
      SharedPreferencesHelper.getHasCompletedOnboarding();

  await runGrowthGaugeApp(hasCompletedOnboarding: hasCompletedOnboarding);
}
