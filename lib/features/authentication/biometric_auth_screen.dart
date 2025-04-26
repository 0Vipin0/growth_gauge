import 'package:flutter/material.dart';

import '../../routes.dart';
import '../../utils/navigation_helper.dart';
import 'authentication.dart';

class BiometricAuthScreen extends StatefulWidget {
  @override
  _BiometricAuthScreenState createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final AuthenticationProvider _authService = AuthenticationProvider();

  @override
  void initState() {
    super.initState();
    _checkBiometricAuth();
  }

  Future<void> _checkBiometricAuth() async {
    final bool isAuthenticated =
        await _authService.authenticateWithBiometrics();
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
    NavigationHelper.replaceWith(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric Authentication')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kindly authenticate yourself',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Authenticating...'),
            ],
          ),
        ),
      ),
    );
  }
}
