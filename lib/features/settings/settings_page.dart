import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';
import '../common/presentation/widgets/responsive_layout.dart';
import 'application/settings_cubit.dart';
import 'application/settings_state.dart';
import 'config/config.dart';
import 'model/model.dart';

class const SettingsPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => _buildSettings(context, state),
      );

  Widget _buildSettings(BuildContext context, SettingsState state) {
    final settings = state.settings;
    final settingsCubit = context.read<SettingsCubit>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ResponsiveContent(
        maxWidth: 800,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (state.error != null) ...[
              Card(
                color: colorScheme.errorContainer,
                child: ListTile(
                  leading: Icon(
                    Icons.warning_amber_outlined,
                    color: colorScheme.onErrorContainer,
                  ),
                  title: Text(
                    state.error!,
                    style: TextStyle(color: colorScheme.onErrorContainer),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Appearance Section
            _buildSectionHeader(context, 'Appearance'),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    _buildSettingItem(
                      context,
                      title: 'App theme',
                      subtitle: 'Select your preferred visual style',
                      control: DropdownButton<AppThemeName>(
                        isExpanded: true,
                        value: settings.themeName,
                        underline: const SizedBox(),
                        items: AppThemeName.values
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.getLabel()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            settingsCubit.updateThemeName(value);
                          }
                        },
                      ),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildSettingItem(
                      context,
                      title: 'Font size',
                      subtitle: 'Adjust text scale across the app',
                      control: DropdownButton<AppFontSize>(
                        isExpanded: true,
                        value: settings.fontSize,
                        underline: const SizedBox(),
                        items: AppFontSize.values
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.getLabel()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            settingsCubit.updateFontSize(value);
                          }
                        },
                      ),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildSettingItem(
                      context,
                      title: 'Font family',
                      subtitle: 'Choose typography style',
                      control: DropdownButton<AppFontFamily>(
                        isExpanded: true,
                        value: settings.fontFamily,
                        underline: const SizedBox(),
                        items: AppFontFamily.values
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.getLabel()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            settingsCubit.updateFontFamily(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Notifications Section
            _buildSectionHeader(context, 'Notifications'),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildSettingItem(
                  context,
                  title: 'Notification time',
                  subtitle: 'Daily reminder schedule for workouts',
                  control: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                        settings.notificationTime?.format(context) ??
                            'Set time',
                      ),
                      onPressed: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime:
                              settings.notificationTime ?? TimeOfDay.now(),
                        );
                        if (time != null) {
                          await settingsCubit.updateNotificationTime(time);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Data & Security Section
            _buildSectionHeader(context, 'Data & Security'),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Backup and restore'),
                      subtitle: const Text(
                        'Export or restore your Growth Gauge data',
                      ),
                      trailing: const Icon(Icons.backup_outlined),
                      onTap: () => context.push(appRouteBackupRestore),
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    _buildSettingItem(
                      context,
                      title: 'Authentication type',
                      subtitle: 'Secure your app with biometrics or PIN',
                      control: DropdownButton<AuthenticationType>(
                        isExpanded: true,
                        value: settings.authenticationType,
                        underline: const SizedBox(),
                        items: AuthenticationType.values
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.getLabel()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) async {
                          if (value == null) return;
                          final previous = settings.authenticationType;
                          if (value == AuthenticationType.biometric &&
                              !await settingsCubit.isBiometricAvailable()) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Biometric authentication is unavailable.',
                                  ),
                                ),
                              );
                            }
                            return;
                          }
                          await settingsCubit.updateAuthenticationType(value);
                          if (value == AuthenticationType.pin &&
                              previous == AuthenticationType.none &&
                              context.mounted) {
                            context.go(appRoutePinAuth);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget control,
  }) {
    final isSmallScreen = MediaQuery.of(context).size.width < 650;

    if (isSmallScreen) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: control),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            SizedBox(
              width: 260, // Wide enough to show complete text cleanly
              child: control,
            ),
          ],
        ),
      );
    }
  }
}
