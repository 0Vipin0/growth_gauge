import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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

    // Initialize animation controllers and animations
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

    // Start logo animation
    _logoController.forward();

    // Start title animation after logo animation is complete
    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _titleController.forward();
      }
    });

    // Navigate to Onboarding screen after a delay
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 4), () {
        _checkOnboardingStatus();
      });
    });
  }

  Future<void> _checkOnboardingStatus() async {
    final bool hasCompletedOnboarding =
        await SharedPreferencesHelper.getHasCompletedOnboarding() ?? false;

    if (hasCompletedOnboarding) {
      navigateToAuthentication();
    } else {
      _navigateToOnboarding();
    }
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacementNamed('/onboarding');
  }

  void _navigateToPinAuth() {
    Navigator.of(context).pushReplacementNamed('/pin_auth');
  }

  void _navigateToBiometricAuth() {
    Navigator.of(context).pushReplacementNamed('/biometric_auth');
  }

  Future<void> navigateToAuthentication() async {
    final AuthenticationProvider authService = AuthenticationProvider();
    final bool isBiometricAvailable =
        await authService.authenticateWithBiometrics();

    if (isBiometricAvailable) {
      _navigateToBiometricAuth();
    } else {
      _navigateToPinAuth();
    }
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
            // Logo animation
            ScaleTransition(
              scale: _logoAnimation,
              child: Image.asset(
                'assets/images/icon.png',
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
              ),
            ),
            const SizedBox(height: 20),
            // Application title animation
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
