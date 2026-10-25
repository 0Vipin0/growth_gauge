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
const appRouteActiveSession = '/active_session';
const appRouteSessionSummary = '/session_summary';
const appRoutePrTrophies = '/pr_trophies';
const appRouteExerciseProgression = '/exercise_progression';
const appRouteCustomExercise = '/custom_exercise';
const appRouteExerciseDetail = '/exercise_detail';
const appRouteTemplateDetail = '/template_detail';
const appRouteTemplateEditor = '/template_editor';

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
const appRouteNameActiveSession = 'active-session';
const appRouteNameSessionSummary = 'session-summary';
const appRouteNamePrTrophies = 'pr-trophies';
const appRouteNameExerciseProgression = 'exercise-progression';
const appRouteNameCustomExercise = 'custom-exercise';
const appRouteNameExerciseDetail = 'exercise-detail';
const appRouteNameTemplateDetail = 'template-detail';
const appRouteNameTemplateEditor = 'template-editor';

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
  required GoRouterWidgetBuilder builder,
}) => GoRoute(
  path: path,
  name: name,
  pageBuilder: (context, state) => CustomTransitionPage<void>(
    key: state.pageKey,
    child: builder(context, state),
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
