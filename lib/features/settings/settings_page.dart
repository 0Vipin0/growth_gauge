// settings_page.dart

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../counter/counter.dart';
import '../timer/timer.dart';
import 'font_config.dart';
import 'settings_provider.dart';
import 'theme_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final counterListProvider = Provider.of<CounterListProvider>(context);
    final timerListProvider = Provider.of<TimerListProvider>(context);

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
            const Divider(), // Separator for data management options
            ListTile(
              title: const Text('Export Data'),
              trailing: const Icon(Icons.file_upload),
              onTap: () {
                settingsProvider
                    .exportData(
                        counterListProvider.counters, timerListProvider.timers)
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Data exported successfully!')),
                  );
                }).catchError((onError) {
                  onError = onError.toString().replaceAll("Exception:", "");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error exporting data: $onError')),
                  );
                }); // Pass data
              },
            ),
            ListTile(
              title: const Text('Import Data'),
              trailing: const Icon(Icons.file_download),
              onTap: () {
                settingsProvider
                    .importData(counterListProvider.importCountersFromData,
                        timerListProvider.importTimersFromData)
                    .then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Data imported successfully!')),
                  );
                }).catchError((onError) {
                  onError = onError.toString().replaceAll("Exception:", "");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error importing data: $onError')),
                  );
                }); // Pass providers
              },
            ),
          ],
        ),
      ),
    );
  }
}
