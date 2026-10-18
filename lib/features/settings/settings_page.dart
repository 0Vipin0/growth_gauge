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
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true),
      body: ResponsiveContent(
        maxWidth: 760,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (state.error != null)
              ListTile(
                leading: const Icon(Icons.warning_amber_outlined),
                title: Text(state.error!),
              ),
            ListTile(
              title: const Text('App theme'),
              trailing: SizedBox(
                width: 180,
                child: DropdownButton<AppThemeName>(
                  isExpanded: true,
                  value: settings.themeName,
                  items: AppThemeName.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.getLabel()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) settingsCubit.updateThemeName(value);
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text('Font size'),
              trailing: SizedBox(
                width: 180,
                child: DropdownButton<AppFontSize>(
                  isExpanded: true,
                  value: settings.fontSize,
                  items: AppFontSize.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.getLabel()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) settingsCubit.updateFontSize(value);
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text('Font family'),
              trailing: SizedBox(
                width: 180,
                child: DropdownButton<AppFontFamily>(
                  isExpanded: true,
                  value: settings.fontFamily,
                  items: AppFontFamily.values
                      .map(
                        (value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.getLabel()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) settingsCubit.updateFontFamily(value);
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text('Notification time'),
              trailing: SizedBox(
                width: 180,
                child: TextButton(
                  child: Text(
                    settings.notificationTime?.format(context) ?? 'Set time',
                  ),
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: settings.notificationTime ?? TimeOfDay.now(),
                    );
                    if (time != null) {
                      await settingsCubit.updateNotificationTime(time);
                    }
                  },
                ),
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
              trailing: SizedBox(
                width: 180,
                child: DropdownButton<AuthenticationType>(
                  isExpanded: true,
                  value: settings.authenticationType,
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
            ),
          ],
        ),
      ),
    );
  }
}
