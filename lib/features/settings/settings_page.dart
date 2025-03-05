import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              title: const Text('Theme Color'),
              trailing: DropdownButton<Color>(
                value: settingsProvider.settings.themeColor,
                items: const [
                  DropdownMenuItem(
                    value: Colors.blue,
                    child: Text('Blue'),
                  ),
                  DropdownMenuItem(
                    value: Colors.red,
                    child: Text('Red'),
                  ),
                  DropdownMenuItem(
                    value: Colors.green,
                    child: Text('Green'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    settingsProvider.updateThemeColor(value);
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
