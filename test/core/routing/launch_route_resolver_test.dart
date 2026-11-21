import 'package:flutter_test/flutter_test.dart';

import 'package:growth_gauge/core/routing/app_router.dart';
import 'package:growth_gauge/core/routing/launch_route_resolver.dart';

void main() {
  group('resolveLaunchRoute', () {
    test('sends first-run users to onboarding', () {
      expect(
        resolveLaunchRoute(hasCompletedOnboarding: false),
        appRouteOnboarding,
      );
    });

    test('sends returning users to the authentication launch gate', () {
      expect(resolveLaunchRoute(hasCompletedOnboarding: true), appRouteLaunch);
    });
  });
}
