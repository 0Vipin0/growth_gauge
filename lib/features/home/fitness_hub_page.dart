import 'package:flutter/material.dart';

import '../../routes.dart';

class const FitnessHubPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Strength & conditioning')),
    body: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Plan your training',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text('Browse exercises and build reusable workout templates.'),
        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.fitness_center),
            title: const Text('Exercise catalog'),
            subtitle: const Text('Search, filter, and manage exercises'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.exerciseCatalog),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.view_agenda),
            title: const Text('Workout templates'),
            subtitle: const Text('Create and prescribe reusable plans'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.workoutTemplates),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.insights),
            title: const Text('Analytics & progress'),
            subtitle: const Text('Review workout history, volume, and PRs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.analytics),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.flag),
            title: const Text('Training goals'),
            subtitle: const Text(
              'Set targets and track strength & volume progress',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.goals),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.straighten),
            title: const Text('Body measurements'),
            subtitle: const Text(
              'Log weight, body composition, and circumferences',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.measurements),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile & equipment'),
            subtitle: const Text(
              'Manage preferences, units, and available gear',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
          ),
        ),
      ],
    ),
  );
}
