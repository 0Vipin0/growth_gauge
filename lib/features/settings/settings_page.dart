import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'app_theme_mode.dart';
import 'font_size_config.dart';
import 'settings_provider.dart';

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
              trailing: DropdownButton<AppThemeMode>(
                value: settingsProvider.settings.themeMode,
                items: AppThemeMode.values.map((AppThemeMode mode) {
                  return DropdownMenuItem<AppThemeMode>(
                    value: mode,
                    child:
                        Text(mode.getLabel()), // Use extension method for label
                  );
                }).toList(),
                onChanged: (AppThemeMode? value) {
                  if (value != null) {
                    settingsProvider.updateThemeMode(value);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Font Size'),
              trailing: DropdownButton<double>(
                value: settingsProvider.settings.fontSize,
                items: const [
                  DropdownMenuItem(
                    value: FontSizeConfig.small,
                    child: Text('Small'),
                  ),
                  DropdownMenuItem(
                    value: FontSizeConfig.medium,
                    child: Text('Medium'),
                  ),
                  DropdownMenuItem(
                    value: FontSizeConfig.large,
                    child: Text('Large'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    settingsProvider.updateFontSize(value);
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

// Example file picker functions (Implement actual file/directory picking logic)
// Future<void> _pickExportDirectory(SettingsProvider settingsProvider) async {
//   String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
//   if (selectedDirectory != null) {
//     settingsProvider.updateExportPath(selectedDirectory);
//   }
// }

// Future<void> _pickImportDirectory(SettingsProvider settingsProvider) async {
//   String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
//   if (selectedDirectory != null) {
//     settingsProvider.updateImportPath(selectedDirectory);
//   }
// }
}
