import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'features/home/home.dart';
import 'features/onboarding/onboarding.dart';
import 'features/settings/settings.dart';
import 'features/splash/splash.dart';
import 'features/authentication/biometric_auth_screen.dart';
import 'features/authentication/pin_auth_screen.dart';

mixin AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String biometricAuth = '/biometric-auth';
  static const String pinAuth = '/pin-auth';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return PageTransition(
          child: const SplashScreen(),
          settings: routeSettings,
          type: PageTransitionType.rightToLeftWithFade,
        );
      case onboarding:
        return PageTransition(
          child: const OnboardingScreen(),
          settings: routeSettings,
          type: PageTransitionType.rightToLeftWithFade,
        );
      case home:
        return PageTransition(
          child: const HomePage(),
          settings: routeSettings,
          type: PageTransitionType.rightToLeftWithFade,
        );
      case settings:
        return PageTransition(
          child: const SettingsPage(),
          settings: routeSettings,
          type: PageTransitionType.rightToLeftWithFade,
        );
      case biometricAuth:
        return MaterialPageRoute(builder: (_) => BiometricAuthScreen());
      case pinAuth:
        return MaterialPageRoute(builder: (_) => PinAuthScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
