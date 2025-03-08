// settings_page.dart

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'font_config.dart';
import 'settings_provider.dart';
import 'theme_config.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

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
              title: const Text('Export Path'),
              subtitle: Text(settingsProvider.settings.exportPath ?? 'Not Set'),
              trailing: IconButton(
                icon: const Icon(Icons.folder_open),
                onPressed: () {
                  // Implement file picker for export path
                  // Example: _pickExportDirectory(settingsProvider);
                },
              ),
            ),
            ListTile(
              title: const Text('Import Path'),
              subtitle: Text(settingsProvider.settings.importPath ?? 'Not Set'),
              trailing: IconButton(
                icon: const Icon(Icons.folder_open),
                onPressed: () {
                  // Implement file picker for import path
                  // Example: _pickImportDirectory(settingsProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
