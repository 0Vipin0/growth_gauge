import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../settings/application/settings_cubit.dart';
import '../settings/application/settings_state.dart';
import 'launch_route_resolver.dart';

/// Resolves saved access settings before opening the fitness home flow.
class const FitnessLaunchScreen({super.key}) extends StatefulWidget {
  @override
  State<FitnessLaunchScreen> createState() => _FitnessLaunchScreenState();
}

class _FitnessLaunchScreenState() extends State<FitnessLaunchScreen> {
  bool _navigated = false;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isReady && !_navigated) {
            _navigated = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              context.go(
                appRouteForAuthentication(state.settings.authenticationType),
              );
            });
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      );
}
