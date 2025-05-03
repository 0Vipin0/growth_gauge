import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'features/authentication/authentication.dart';
import 'features/home/home.dart';
import 'features/onboarding/onboarding.dart';
import 'features/settings/settings.dart';
import 'features/splash/splash.dart';

mixin AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String biometricAuth = '/biometric_auth';
  static const String pinAuth = '/pin_auth';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    home: (_) => const HomePage(),
    settings: (_) => const SettingsPage(),
    biometricAuth: (_) => BiometricAuthScreen(),
    pinAuth: (_) => PinAuthScreen(),
  };

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final WidgetBuilder? builder = _routes[routeSettings.name];
    if (builder != null) {
      return PageTransition(
        child: Builder(builder: builder),
        settings: routeSettings,
        type: PageTransitionType.rightToLeftWithFade,
      );
    }
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for ${routeSettings.name}'),
        ),
      ),
    );
  }
}
