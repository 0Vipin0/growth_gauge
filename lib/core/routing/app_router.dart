import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const appRouteLaunch = '/launch';
const appRouteHome = '/home';
const appRouteSettings = '/settings';
const appRouteBiometricAuth = '/biometric_auth';
const appRoutePinAuth = '/pin_auth';
const appRouteExerciseCatalog = '/exercise_catalog';
const appRouteWorkoutTemplates = '/workout_templates';
const appRouteAnalytics = '/analytics';
const appRouteProfile = '/profile';
const appRouteGoals = '/goals';
const appRouteMeasurements = '/measurements';
const appRouteBackupRestore = '/backup_restore';

const appRouteNameLaunch = 'launch';
const appRouteNameHome = 'home';
const appRouteNameSettings = 'settings';
const appRouteNameBiometricAuth = 'biometric-auth';
const appRouteNamePinAuth = 'pin-auth';
const appRouteNameExerciseCatalog = 'exercise-catalog';
const appRouteNameWorkoutTemplates = 'workout-templates';
const appRouteNameAnalytics = 'analytics';
const appRouteNameProfile = 'profile';
const appRouteNameGoals = 'goals';
const appRouteNameMeasurements = 'measurements';
const appRouteNameBackupRestore = 'backup-restore';

/// Owns GoRouter lifecycle, the app-wide transition, and unmatched paths.
class AppRouter({
  required final String initialLocation,
  required final List<RouteBase> routes,
}) {
  late final GoRouter router = GoRouter(
    initialLocation: initialLocation,
    routes: routes,
    errorBuilder: (_, state) => Scaffold(
      body: Center(child: Text('No route defined for ${state.uri.path}')),
    ),
  );
}

/// Builds a consistently transitioned application destination.
GoRoute appGoRoute({
  required String path,
  required String name,
  required WidgetBuilder builder,
}) => GoRoute(
  path: path,
  name: name,
  pageBuilder: (context, state) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: builder(context),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(0.08, 0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOutCubic)),
            ),
            child: child,
          ),
        ),
  ),
);
