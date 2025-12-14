import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import 'features/authentication/authentication.dart';
import 'features/home/home.dart';
import 'features/onboarding/onboarding.dart';
import 'features/settings/settings.dart';
import 'features/profile/widgets/profile_page.dart';
import 'features/profile/widgets/profile_edit_page.dart';
import 'features/insights/insights.dart';
import 'features/workout/widgets/workout_templates_page.dart';
import 'features/splash/splash.dart';

mixin AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String settings = '/settings';
  static const String biometricAuth = '/biometric_auth';
  static const String pinAuth = '/pin_auth';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String activityList = '/activity';
  static const String activityDetail = '/activity/detail';
  static const String activityInsights = '/activity/insights';
  static const String workoutTemplates = '/workouts/templates';

  static final Map<String, Widget Function(BuildContext)> _routes = {
    splash: (_) => const SplashScreen(),
    onboarding: (_) => const OnboardingScreen(),
    home: (_) => const HomePage(),
    settings: (_) => const SettingsPage(),
    biometricAuth: (_) => BiometricAuthScreen(),
    pinAuth: (_) => PinAuthScreen(),
    profile: (_) => const ProfilePage(),
    profileEdit: (_) => const ProfileEditPage(),
    activityList: (_) => const ActivityListWidget(),
    activityDetail: (_) => const ActivityDetailPage(),
    activityInsights: (_) => const InsightsPage(),
    workoutTemplates: (_) => const WorkoutTemplatesPage(),
    '/workouts/detail': (_) => Builder(builder: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      final id = args?['id'] as String?;
      if (id == null) return const Scaffold(body: Center(child: Text('No template specified')));
      return WorkoutTemplateDetailPage(templateId: id);
    }),
    '/workouts/run': (_) => const WorkoutRunPage(),
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
