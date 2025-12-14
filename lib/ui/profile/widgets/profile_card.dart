import 'package:flutter/material.dart';

import '../../../data/models/models.dart';

class ProfileCard extends StatelessWidget {
  final UserProfile profile;

  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final score = (profile.fitnessScore ?? 0).clamp(0, 100).toDouble();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile', style: theme.textTheme.titleMedium),
                Text('Score: ${score.toInt()}',
                    style: theme.textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
                value: score / 100.0, semanticsLabel: 'Fitness score'),
            const SizedBox(height: 12),
            Wrap(
              runSpacing: 8,
              children: [
                _infoTile('Age', profile.data?.age?.toString() ?? '—'),
                _infoTile(
                    'Height (cm)', profile.data?.heightCm?.toString() ?? '—'),
                _infoTile(
                    'Weight (kg)', profile.data?.weightKg?.toString() ?? '—'),
                _infoTile(
                    'RHR', profile.data?.restingHeartRate?.toString() ?? '—'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
