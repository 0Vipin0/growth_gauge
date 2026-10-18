import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../settings/settings.dart';
import 'launch_route_resolver.dart';

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
          context.go(
            appRouteForAuthentication(settings.settings.authenticationType),
          );
        });
      }
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    },
  );
}
