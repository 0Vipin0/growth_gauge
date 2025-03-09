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
            const Divider(),
            ListTile(
              title: const Text('Export Data'),
              trailing: settingsProvider.isExporting
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.file_upload),
              onTap: () {
                settingsProvider.exportData(
                    counterListProvider.counters, timerListProvider.timers);
              },
            ),
            ListTile(
              title: const Text('Import Data'),
              trailing: settingsProvider.isImporting
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.file_download),
              onTap: () {
                settingsProvider.importData(
                    counterListProvider.importCountersFromData,
                    timerListProvider.importTimersFromData);
              },
            ),
          ],
        ),
      ),
    );
  }
}
