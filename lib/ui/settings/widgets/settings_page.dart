import 'dart:async';

import 'package:flutter/material.dart';
import 'package:growth_gauge/data/models/models.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../core/font_config.dart';
import '../../core/theme_config.dart';
import '../provider/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (settingsProvider.exportMessage != '') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(settingsProvider.exportMessage)));
        settingsProvider.exportMessage = '';
      }
      if (settingsProvider.importMessage != '') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(settingsProvider.importMessage)));
        settingsProvider.importMessage = '';
      }
    });

    return FutureBuilder<bool>(
      future: settingsProvider.isBiometricAvailable(),
      builder: (context, snapshot) {
        final isBiometricAvailable = snapshot.data ?? false;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('App Theme'),
                  trailing: DropdownButton<AppThemeName>(
                    value: settingsProvider.settings.themeName,
                    items: AppThemeName.values.map((AppThemeName mode) {
                      return DropdownMenuItem<AppThemeName>(
                        value: mode,
                        child: Text(mode.getLabel()),
                      );
                    }).toList(),
                    onChanged: (AppThemeName? value) {
                      if (value != null) {
                        settingsProvider.updateThemeName(value);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Font Size'),
                  trailing: DropdownButton<AppFontSize>(
                    value: settingsProvider.settings.fontSize,
                    items: AppFontSize.values.map((AppFontSize size) {
                      return DropdownMenuItem<AppFontSize>(
                        value: size,
                        child: Text(size.getLabel()),
                      );
                    }).toList(),
                    onChanged: (AppFontSize? value) {
                      if (value != null) {
                        settingsProvider.updateFontSize(value);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Font Family'),
                  trailing: DropdownButton<AppFontFamily>(
                    value: settingsProvider.settings.fontFamily,
                    items: AppFontFamily.values.map((AppFontFamily family) {
                      return DropdownMenuItem<AppFontFamily>(
                        value: family,
                        child: Text(family.getLabel()),
                      );
                    }).toList(),
                    onChanged: (AppFontFamily? value) {
                      if (value != null) {
                        settingsProvider.updateFontFamily(value);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Export Format'),
                  trailing: DropdownButton<ExportFormat>(
                    value: settingsProvider.settings.exportFormat,
                    items: ExportFormat.values.map((ExportFormat mode) {
                      return DropdownMenuItem<ExportFormat>(
                        value: mode,
                        child: Text(mode.getLabel()),
                      );
                    }).toList(),
                    onChanged: (ExportFormat? value) {
                      if (value != null) {
                        settingsProvider.updateExportFormat(value);
                      }
                      if (value == ExportFormat.csv) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Setting Export Format to CSV does not change import format which still needs JSON',
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Show Onboarding'),
                  trailing: Switch(
                    value: !settingsProvider.isOnboardingComplete,
                    onChanged: (bool value) {
                      settingsProvider.toggleOnboarding(!value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'You will now be redirected to onboarding screen in few seconds.',
                          ),
                        ),
                      );
                      Timer(const Duration(seconds: 3), () {
                        context.pushNamedTransition(
                          routeName: '/onboarding',
                          type: PageTransitionType.topToBottom,
                        );
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Notification Time'),
                  trailing: TextButton(
                    child: Text(
                      settingsProvider.settings.notificationTime
                              ?.format(context) ??
                          'Set Time',
                    ),
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime:
                            settingsProvider.settings.notificationTime ??
                                TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        settingsProvider.updateNotificationTime(pickedTime);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('TTS Cues (Voice Guidance)'),
                  trailing: Switch(
                    value: settingsProvider.settings.ttsEnabled,
                    onChanged: (bool value) {
                      settingsProvider.updateTtsEnabled(value);
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Export Data'),
                  trailing: settingsProvider.isExporting
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.file_upload),
                  onTap: () {
                    if (settingsProvider.settings.exportFormat ==
                        ExportFormat.json) {
                      settingsProvider.exportData();
                    } else if (settingsProvider.settings.exportFormat ==
                        ExportFormat.csv) {
                      settingsProvider.exportDataToCsv();
                    }
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Profile'),
                  trailing: const Icon(Icons.person),
                  onTap: () => Navigator.of(context).pushNamed('/profile'),
                ),
                ListTile(
                  title: const Text('Import Data'),
                  trailing: settingsProvider.isImporting
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.file_download),
                  onTap: () {
                    settingsProvider.importData();
                  },
                ),
                ListTile(
                  title: const Text('Authentication Type'),
                  trailing: DropdownButton<AuthenticationType>(
                    value: settingsProvider.settings.authenticationType,
                    items: AuthenticationType.values
                        .map((AuthenticationType mode) {
                      return DropdownMenuItem<AuthenticationType>(
                        value: mode,
                        child: Text(
                          mode.getLabel(),
                          style: mode == AuthenticationType.biometric &&
                                  !isBiometricAvailable
                              ? const TextStyle(color: Colors.grey)
                              : null,
                        ),
                      );
                    }).toList(),
                    onChanged: (AuthenticationType? value) {
                      if (value != null) {
                        if (value == AuthenticationType.biometric &&
                            !isBiometricAvailable) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Biometric authentication is not available on this device.'),
                            ),
                          );
                          return;
                        }
                        if (value == AuthenticationType.pin &&
                            settingsProvider.settings.authenticationType ==
                                AuthenticationType.none) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'You will now be redirected to set your PIN and login again.'),
                            ),
                          );
                          Timer(const Duration(seconds: 2), () {
                            Navigator.of(context)
                                .pushReplacementNamed('/pin_auth');
                          });
                        }
                        settingsProvider.updateAuthenticationType(value);
                        if (value == AuthenticationType.none) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Pin Authentication data has been cleared.'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Reset Application Data'),
                  trailing: const Icon(Icons.lock_reset),
                  onTap: () => showResetDialog(context, settingsProvider),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showResetDialog(
    BuildContext context,
    SettingsProvider settingsProvider,
  ) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Application Data'),
          content: const Text(
            'Are you sure to clear all the application data?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                settingsProvider.clearAppData();
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
