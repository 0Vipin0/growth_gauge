import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

import '../../routes.dart';
import '../../utils/navigation_helper.dart';
import '../authentication/authentication.dart';
import '../settings/settings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
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
        await SharedPreferencesHelper.getHasCompletedOnboarding() ?? false;

    if (!mounted) return;

    if (hasCompletedOnboarding) {
      _handlePostOnboardingNavigation();
    } else {
      _navigateTo(AppRoutes.onboarding);
    }
  }

  void _handlePostOnboardingNavigation() {
    final SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    if (settingsProvider.settings.authenticationType ==
        AuthenticationType.none) {
      _navigateTo(AppRoutes.home);
    } else {
      _navigateToAuthentication();
    }
  }

  Future<void> _navigateToAuthentication() async {
    final AuthenticationProvider authService = AuthenticationProvider();
    final SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);

    final bool isBiometricAvailable =
        await authService.canAuthenticateWithBiometrics();

    final String route =
        isBiometricAvailable ? AppRoutes.biometricAuth : AppRoutes.pinAuth;

    settingsProvider.updateAuthenticationType(
      isBiometricAvailable
          ? AuthenticationType.biometric
          : AuthenticationType.pin,
    );

    _navigateTo(route);
  }

  void _navigateTo(String route) {
    NavigationHelper.replaceWith(context, route);
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
                'assets/images/icon.png',
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
