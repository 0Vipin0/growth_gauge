// launch_route_resolver.dart

import '../../../../core/routing/app_router.dart';
import '../../../settings/domain/settings_model.dart';

/// Resolves the launch route.
/// NOTE: Currently configured in testing mode to force Onboarding on launch.
String resolveLaunchRoute({
  required bool hasCompletedOnboarding,
  required AuthenticationType authType,
  bool forceTestOnboarding = true, // Set to false when switching to production
}) {
  if (forceTestOnboarding || !hasCompletedOnboarding) {
    return appRouteOnboarding;
  }

  return appRouteForAuthentication(authType);
}

String appRouteForAuthentication(AuthenticationType type) => switch (type) {
  AuthenticationType.pin => appRoutePinAuth,
  AuthenticationType.biometric => appRouteBiometricAuth,
  AuthenticationType.none => appRouteHome,
};
