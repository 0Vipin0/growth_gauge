import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:go_router/go_router.dart';

import 'package:growth_gauge/gen/assets.gen.dart';

import '../../../core/routing/launch_route_resolver.dart';
import '../../settings/config/shared_preferences_config.dart';

class const SplashScreen({super.key, final bool? hasCompletedOnboarding})
    extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState()
    extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _titleController;
  late Animation<double> _logoAnimation;
  late Animation<double> _titleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _scheduleNavigation();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _titleController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    );

    _titleAnimation = CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeInOut,
    );
  }

  void _startAnimations() {
    _logoController.forward();
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _titleController.forward();
      }
    });
  }

  void _scheduleNavigation() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), _checkOnboardingStatus);
    });
  }

  Future<void> _checkOnboardingStatus() async {
    final bool hasCompletedOnboarding =
        widget.hasCompletedOnboarding ??
        SharedPreferencesHelper.getHasCompletedOnboarding();

    if (!mounted) return;

    _navigateTo(
      resolveLaunchRoute(hasCompletedOnboarding: hasCompletedOnboarding),
    );
  }

  void _navigateTo(String route) {
    context.go(route);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScaleTransition(
              scale: _logoAnimation,
              child: Image.asset(
                Assets.images.png.icon.path,
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: _titleAnimation,
              child: Text(
                'Growth Gauge',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
