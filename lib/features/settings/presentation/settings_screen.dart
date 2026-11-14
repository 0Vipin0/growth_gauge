import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/routing.dart';
import '../../common/presentation/theme/theme.dart';
import '../../common/presentation/utils/responsive_layout.dart';
import '../../common/presentation/widgets/widgets.dart';
import '../application/application.dart';
import '../domain/domain.dart';

class const SettingsScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) => _buildSettings(context, state),
      );

  Widget _buildSettings(BuildContext context, SettingsState state) {
    final settings = state.settings;
    final settingsCubit = context.read<SettingsCubit>();

    // Build preview theme dynamically using state settings
    final previewTheme = settings.toThemeData(context);
    final colorScheme = previewTheme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Appearance & Settings'),
        centerTitle: true,
      ),
      body: ResponsiveContent(
        maxWidth: 800,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (state.error != null) ...[
              AppCard(
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_outlined,
                      color: colorScheme.error,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        state.error!,
                        style: TextStyle(color: colorScheme.error),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // 1. REAL-TIME LIVE PREVIEW CARD SECTION
            _buildSectionHeader(context, 'Live Theme Preview'),
            const SizedBox(height: 8),
            Theme(
              data: previewTheme,
              child: Builder(
                builder: (previewContext) {
                  return AppCard(
                    variant: AppCardVariant.selected,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Growth Gauge Preview',
                              style: previewTheme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withValues(
                                  alpha: 0.15,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                settings.themeName.name.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Expanded(
                              child: AppStatCard(
                                title: 'Active Streak',
                                value: '14 Days',
                                trendDelta: '+2',
                                icon: Icons.local_fire_department,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: AppStatCard(
                                title: 'Volume Lifted',
                                value: '4,250 kg',
                                trendDelta: '+12%',
                                icon: Icons.fitness_center,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: AppButton.primary(
                            label: 'Sample Action Button',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // 2. APPEARANCE CONFIGURATION SECTION
            _buildSectionHeader(context, 'Appearance Customization'),
            const SizedBox(height: 8),
            AppCard(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A. Brightness Mode Toggle (Light / Dark / System)
                    Text(
                      'Brightness Mode',
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<ThemeMode>(
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text('Light'),
                          icon: Icon(Icons.wb_sunny_outlined),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text('Dark'),
                          icon: Icon(Icons.nightlight_outlined),
                        ),
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('System'),
                          icon: Icon(Icons.brightness_auto_outlined),
                        ),
                      ],
                      selected: {settings.themeMode},
                      onSelectionChanged: (selected) {
                        settingsCubit.updateThemeMode(selected.first);
                      },
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 24),

                    // B. 8-Swatch Seed Grid Selection
                    Text(
                      'Theme Seed Palette',
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Select from 8 curated athletic color palettes',
                      style: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 2.2,
                          ),
                      itemCount: AppThemeName.values.length,
                      itemBuilder: (context, index) {
                        final swatchName = AppThemeName.values[index];
                        final isSelected = settings.themeName == swatchName;

                        return InkWell(
                          onTap: () =>
                              settingsCubit.updateThemeName(swatchName),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorScheme.primaryContainer
                                  : colorScheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.outlineVariant,
                                width: isSelected ? 2.0 : 1.0,
                              ),
                            ),
                            child: Text(
                              swatchName.name.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? colorScheme.onPrimaryContainer
                                    : colorScheme.onSurface,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 24),

                    // C. Font Family Choice (Pill Selector)
                    Text(
                      'Typography Font Family',
                      style: Theme.of(context).textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: AppFontFamilyChoice.values.map((font) {
                        final isSelected = settings.fontFamilyChoice == font;
                        return ChoiceChip(
                          label: Text(font.name.toUpperCase()),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              settingsCubit.updateFontFamilyChoice(font);
                            }
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 24),

                    // D. Text Size Slider (Continuous/Stepped Multiplier)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Text Size Scale',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${(settings.fontSize.multiplier * 100).toInt()}% (${settings.fontSize.name.toUpperCase()})',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Slider(
                      value: settings.fontSize.index.toDouble(),
                      max: (AppFontSize.values.length - 1).toDouble(),
                      divisions: AppFontSize.values.length - 1,
                      label: settings.fontSize.name.toUpperCase(),
                      onChanged: (double value) {
                        final newSize = AppFontSize.values[value.toInt()];
                        settingsCubit.updateFontSize(newSize);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 3. NOTIFICATIONS SECTION
            _buildSectionHeader(context, 'Notifications'),
            const SizedBox(height: 8),
            AppCard(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              child: ListTile(
                title: const Text('Notification time'),
                subtitle: const Text('Daily reminder schedule for workouts'),
                trailing: AppButton.ghost(
                  label:
                      settings.notificationTime?.format(context) ?? 'Set time',
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

            const SizedBox(height: 24),

            // 4. DATA & SECURITY SECTION
            _buildSectionHeader(context, 'Data & Security'),
            const SizedBox(height: 8),
            AppCard(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Authentication type',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Secure your app with biometrics or PIN',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: AppDropdown<AuthenticationType>(
                            label: 'Auth Type',
                            value: settings.authenticationType,
                            prefixIcon: Icons.lock_outline,
                            items: AuthenticationType.values
                                .map(
                                  (value) =>
                                      AppDropdownItem<AuthenticationType>(
                                        value: value,
                                        label: value.getLabel(),
                                        icon: Icons.security,
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
                              await settingsCubit.updateAuthenticationType(
                                value,
                              );
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
                ],
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
}
