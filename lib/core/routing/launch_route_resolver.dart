import 'app_router.dart';

/// Resolves the post-splash destination from the effective onboarding state.
String resolveLaunchRoute({required bool hasCompletedOnboarding}) =>
    hasCompletedOnboarding ? appRouteLaunch : appRouteOnboarding;
