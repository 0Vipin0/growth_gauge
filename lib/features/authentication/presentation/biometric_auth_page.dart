import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../core/routing/app_router.dart';
import '../../common/presentation/widgets/responsive_form_layout.dart';
import '../infrastructure/authentication_service.dart';

class const BiometricAuthScreen() extends StatefulWidget {
  @override
  _BiometricAuthScreenState createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState() extends State<BiometricAuthScreen> {
  final AuthenticationService _authService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _checkBiometricAuth();
  }

  Future<void> _checkBiometricAuth() async {
    final bool isAuthenticated = await _authService
        .authenticateWithBiometrics();
    if (isAuthenticated) {
      _navigateToHome();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometric authentication failed.')),
        );
      }
    }
  }

  void _navigateToHome() {
    context.go(appRouteHome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Biometric Authentication'),
      ),
      body: ResponsiveFormLayout(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Kindly authenticate yourself',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Semantics(
                  liveRegion: true,
                  label: 'Waiting for biometric authentication',
                  child: const CircularProgressIndicator(),
                ),
                const SizedBox(height: 10),
                const Text('Authenticating...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
