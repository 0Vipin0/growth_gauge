import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_profile_provider.dart';
import 'profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProfileProvider>(context);
    final profile = provider.currentUserProfile;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit profile',
            onPressed: () => Navigator.pushNamed(context, '/profile/edit'),
          )
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (profile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final isWide = constraints.maxWidth >= 600;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: ProfileCard(profile: profile)),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: _detailsColumn(profile),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileCard(profile: profile),
                      const SizedBox(height: 16),
                      _detailsColumn(profile),
                    ],
                  ),
                ),
        );
      }),
    );
  }

  Widget _detailsColumn(profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ID: ${profile.id}'),
        const SizedBox(height: 8),
        Text('Created: ${profile.creationDate.toLocal()}'),
        const SizedBox(height: 8),
        const SizedBox(height: 16),
        const Text('Biometrics', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Age: ${profile.data?.age ?? '—'}'),
        Text('Height (cm): ${profile.data?.heightCm ?? '—'}'),
        Text('Weight (kg): ${profile.data?.weightKg ?? '—'}'),
        Text('RHR: ${profile.data?.restingHeartRate ?? '—'}'),
      ],
    );
  }
}
