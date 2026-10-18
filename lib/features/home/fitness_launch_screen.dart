import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../routes.dart';
import '../settings/settings.dart';

/// Resolves saved access settings before opening the fitness home flow.
class const FitnessLaunchScreen({super.key}) extends StatefulWidget {
  @override
  State<FitnessLaunchScreen> createState() => _FitnessLaunchScreenState();
}

class _FitnessLaunchScreenState() extends State<FitnessLaunchScreen> {
  bool _navigated = false;

  @override
  Widget build(BuildContext context) => Consumer<SettingsProvider>(
    builder: (context, settings, _) {
      if (settings.isReady && !_navigated) {
        _navigated = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          final route = switch (settings.settings.authenticationType) {
            AuthenticationType.pin => AppRoutes.pinAuth,
            AuthenticationType.biometric => AppRoutes.biometricAuth,
            AuthenticationType.none => AppRoutes.home,
          };
          Navigator.of(context).pushReplacementNamed(route);
        });
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    },
  );
}
