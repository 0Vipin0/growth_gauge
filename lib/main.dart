import 'package:flutter/material.dart';

import 'core/app/app_runner.dart';
import 'features/settings/config/shared_preferences_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();

  // Real production state check from storage
  final bool hasCompletedOnboarding =
      SharedPreferencesHelper.getHasCompletedOnboarding();

  await runGrowthGaugeApp(hasCompletedOnboarding: hasCompletedOnboarding);
}
