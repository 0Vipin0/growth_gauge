import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/routing/app_router.dart';
import 'config/config.dart';
import 'model/model.dart';
import 'settings_provider.dart';

class const SettingsPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('App theme'),
            trailing: DropdownButton<AppThemeName>(
              value: settings.settings.themeName,
              items: AppThemeName.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.getLabel()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) settings.updateThemeName(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Font size'),
            trailing: DropdownButton<AppFontSize>(
              value: settings.settings.fontSize,
              items: AppFontSize.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.getLabel()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) settings.updateFontSize(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Font family'),
            trailing: DropdownButton<AppFontFamily>(
              value: settings.settings.fontFamily,
              items: AppFontFamily.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value.getLabel()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) settings.updateFontFamily(value);
              },
            ),
          ),
          ListTile(
            title: const Text('Notification time'),
            trailing: TextButton(
              child: Text(
                settings.notificationTime?.format(context) ?? 'Set time',
              ),
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: settings.notificationTime ?? TimeOfDay.now(),
                );
                if (time != null) settings.updateNotificationTime(time);
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Backup and restore'),
            subtitle: const Text('Export or restore your Growth Gauge data'),
            trailing: const Icon(Icons.backup_outlined),
            onTap: () => context.push(appRouteBackupRestore),
          ),
          ListTile(
            title: const Text('Authentication type'),
            trailing: DropdownButton<AuthenticationType>(
              value: settings.settings.authenticationType,
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
                final previous = settings.settings.authenticationType;
                if (value == AuthenticationType.biometric &&
                    !await settings.isBiometricAvailable()) {
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
                settings.updateAuthenticationType(value);
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
    );
  }
}
