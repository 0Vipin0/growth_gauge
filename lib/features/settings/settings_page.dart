import 'dart:async';

import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'font_config.dart';
import 'settings_model.dart';
import 'settings_provider.dart';
import 'theme_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (settingsProvider.exportMessage != "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(settingsProvider.exportMessage)),
        );
        settingsProvider.exportMessage = "";
      }
      if (settingsProvider.importMessage != "") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(settingsProvider.importMessage)),
        );
        settingsProvider.importMessage = "";
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                      SnackBar(
                          content: Text(
                              "Setting Export Format to CSV does not change import format which still needs JSON")),
                    );
                  }
                },
              ),
            ),
            ListTile(
              title: Text("Show Onboarding"),
              trailing: Switch(
                value: !settingsProvider.isOnboardingComplete,
                onChanged: (bool value) {
                  settingsProvider.toggleOnboarding(!value);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            "You will now be redirected to onboarding screen in few seconds.")),
                  );
                  Timer(Duration(seconds: 3), () {
                    context.pushNamedTransition(
                      routeName: '/onboarding',
                      type: PageTransitionType.topToBottom,
                    );
                  });
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
            ListTile(
              title: const Text('Import Data'),
              trailing: settingsProvider.isImporting
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.file_download),
              onTap: () {
                settingsProvider.importData();
              },
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
  }

  showResetDialog(BuildContext context, SettingsProvider settingsProvider) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset Application Data'),
          content:
              const Text('Are you sure to clear all the application data?'),
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
