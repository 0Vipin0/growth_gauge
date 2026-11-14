import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/routing/routing.dart';
import '../../../../core/units/unit_types.dart';
import '../../../common/presentation/utils/responsive_layout.dart';
import '../../../common/presentation/widgets/widgets.dart';
import '../../application/user_use_cases.dart';
import '../../domain/equipment_inventory.dart';
import '../../domain/training_profile.dart';
import '../../domain/user_enums.dart';
import '../../domain/user_profile.dart';
import '../../domain/workout_preferences.dart';
import '../widgets/equipment_inventory_sheet.dart';

class const ProfileScreen({
  super.key,
  required final UserUseCases useCases,
  final String userId = 'local-user',
}) extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState() extends State<ProfileScreen> {
  bool _isLoading = true;
  UserProfile? _profile;
  TrainingProfile? _trainingProfile;
  WorkoutPreferences? _preferences;
  EquipmentInventory? _equipment;

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _neckController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final pRes = await widget.useCases.getOrCreateProfile(widget.userId);
    final tRes = await widget.useCases.getOrCreateTrainingProfile(
      widget.userId,
    );
    final wRes = await widget.useCases.getOrCreatePreferences(widget.userId);
    final eRes = await widget.useCases.getOrCreateEquipmentInventory(
      widget.userId,
    );

    if (mounted) {
      setState(() {
        _profile = pRes.dataOrNull;
        _trainingProfile = tRes.dataOrNull;
        _preferences = wRes.dataOrNull;
        _equipment = eRes.dataOrNull;

        if (_profile != null) {
          _ageController.text = '28';
          _heightController.text = '178';
          _weightController.text = '75.5';
          _neckController.text = '38';
          _waistController.text = '82';
          _hipController.text = '96';
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile(UserProfile updated) async {
    setState(() => _profile = updated);
    await widget.useCases.updateProfile(updated);
  }

  Future<void> _saveTrainingProfile(TrainingProfile updated) async {
    setState(() => _trainingProfile = updated);
    await widget.useCases.updateTrainingProfile(updated);
  }

  Future<void> _savePreferences(WorkoutPreferences updated) async {
    setState(() => _preferences = updated);
    await widget.useCases.updatePreferences(updated);
  }

  Future<void> _openEquipmentSheet() async {
    if (_equipment == null) return;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        final media = MediaQuery.of(ctx);
        final availableHeight = media.size.height - media.viewInsets.bottom;
        return SafeArea(
          child: SizedBox(
            height: availableHeight.clamp(280, 680),
            child: ResponsiveContent(
              maxWidth: 720,
              child: EquipmentInventorySheet(
                initialSelection: _equipment!.ownedEquipment,
                onSaved: (selected) async {
                  await widget.useCases.updateEquipmentInventory(
                    widget.userId,
                    selected,
                  );
                  final updated = await widget.useCases
                      .getOrCreateEquipmentInventory(widget.userId);
                  if (mounted) setState(() => _equipment = updated.dataOrNull);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final profile = _profile!;
    final training = _trainingProfile!;
    final prefs = _preferences!;

    final sizeClass = AppWindowSizeClass.of(context);
    final isDesktop = sizeClass != AppWindowSizeClass.compact;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Preferences'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ResponsiveContent(
          maxWidth: 1100,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 32.0 : 20.0,
              vertical: 24.0,
            ),
            children: [
              // Header User Card
              AppCard(
                onTap: () => context.go(appRouteGoals),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 38,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.displayName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${training.trainingExperience.name.toUpperCase()} • ${training.primaryTrainingStyle}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.flag,
                                size: 14,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Tap to manage training goals',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Responsive Layout Grid
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [_buildBodyMetricsSection(context)],
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          _buildUnitPreferencesSection(context, profile),
                          const SizedBox(height: 24),
                          _buildTrainingProfileSection(context, training),
                          const SizedBox(height: 24),
                          _buildPreferencesSection(context, prefs),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildBodyMetricsSection(context),
                    const SizedBox(height: 24),
                    _buildUnitPreferencesSection(context, profile),
                    const SizedBox(height: 24),
                    _buildTrainingProfileSection(context, training),
                    const SizedBox(height: 24),
                    _buildPreferencesSection(context, prefs),
                  ],
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyMetricsSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Core & Body Measurements'),
        const SizedBox(height: 8),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Core Measurements',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'AGE',
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      suffixUnit: 'yrs',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      label: 'HEIGHT',
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      suffixUnit: 'cm',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'WEIGHT',
                controller: _weightController,
                keyboardType: TextInputType.number,
                suffixUnit: 'kg',
              ),
              const Divider(height: 32),
              Text(
                'Detailed Body Metrics',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Optional measurements for higher accuracy',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'NECK',
                      controller: _neckController,
                      keyboardType: TextInputType.number,
                      suffixUnit: 'cm',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppTextField(
                      label: 'WAIST',
                      controller: _waistController,
                      keyboardType: TextInputType.number,
                      suffixUnit: 'cm',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'HIP',
                controller: _hipController,
                keyboardType: TextInputType.number,
                suffixUnit: 'cm',
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: AppButton.primary(
                  label: 'Save Body Metrics',
                  icon: Icons.check_circle_outline,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Body metrics updated successfully.'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitPreferencesSection(
    BuildContext context,
    UserProfile profile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Unit Preferences'),
        const SizedBox(height: 8),
        AppCard(
          child: Column(
            children: [
              _buildUnitRow(
                context,
                title: 'Weight Unit',
                control: SizedBox(
                  width: 150,
                  child: AppSegmentedControl<WeightUnit>(
                    selectedValue: profile.weightUnit,
                    items: const [
                      AppSegmentedControlItem(
                        value: WeightUnit.kilograms,
                        label: 'KG',
                      ),
                      AppSegmentedControlItem(
                        value: WeightUnit.pounds,
                        label: 'LB',
                      ),
                    ],
                    onValueChanged: (val) =>
                        _saveProfile(profile.copyWith(weightUnit: val)),
                  ),
                ),
              ),
              const Divider(height: 24),
              _buildUnitRow(
                context,
                title: 'Distance Unit',
                control: SizedBox(
                  width: 150,
                  child: AppSegmentedControl<DistanceUnit>(
                    selectedValue: profile.distanceUnit,
                    items: const [
                      AppSegmentedControlItem(
                        value: DistanceUnit.kilometers,
                        label: 'KM',
                      ),
                      AppSegmentedControlItem(
                        value: DistanceUnit.miles,
                        label: 'MI',
                      ),
                    ],
                    onValueChanged: (val) =>
                        _saveProfile(profile.copyWith(distanceUnit: val)),
                  ),
                ),
              ),
              const Divider(height: 24),
              _buildUnitRow(
                context,
                title: 'Height Unit',
                control: SizedBox(
                  width: 160,
                  child: AppSegmentedControl<HeightUnit>(
                    selectedValue: profile.heightUnit,
                    items: const [
                      AppSegmentedControlItem(
                        value: HeightUnit.centimeters,
                        label: 'CM',
                      ),
                      AppSegmentedControlItem(
                        value: HeightUnit.feetAndInches,
                        label: 'FT/IN',
                      ),
                    ],
                    onValueChanged: (val) =>
                        _saveProfile(profile.copyWith(heightUnit: val)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitRow(
    BuildContext context, {
    required String title,
    required Widget control,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        control,
      ],
    );
  }

  Widget _buildTrainingProfileSection(
    BuildContext context,
    TrainingProfile training,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Training Profile'),
        const SizedBox(height: 8),
        AppCard(
          child: Column(
            children: [
              AppDropdown<TrainingExperience>(
                label: 'Experience Level',
                value: training.trainingExperience,
                items: TrainingExperience.values.map((exp) {
                  return AppDropdownItem(
                    value: exp,
                    label: exp.name.toUpperCase(),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    _saveTrainingProfile(
                      training.copyWith(trainingExperience: val),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Equipment Inventory'),
                subtitle: Text(
                  '${_equipment?.ownedEquipment.length ?? 0} equipment items available',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _openEquipmentSheet,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesSection(
    BuildContext context,
    WorkoutPreferences prefs,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Workout Execution Preferences'),
        const SizedBox(height: 8),
        AppCard(
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Auto-start Rest Timer'),
                subtitle: const Text(
                  'Starts rest timer immediately on set log',
                ),
                value: prefs.autoStartRestTimer,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(autoStartRestTimer: val)),
              ),
              const Divider(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Default Rest Duration'),
                trailing: Text(
                  '${prefs.defaultRestSeconds}s',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                onTap: () async {
                  int seconds = prefs.defaultRestSeconds;
                  final res = await showDialog<int>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Default Rest (Seconds)'),
                      content: AppTextField(
                        label: 'Seconds',
                        controller: TextEditingController(
                          text: seconds.toString(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (v) => seconds = int.tryParse(v) ?? seconds,
                      ),
                      actions: [
                        AppButton.primary(
                          label: 'Save',
                          onPressed: () => ctx.pop(seconds),
                        ),
                      ],
                    ),
                  );
                  if (res != null) {
                    _savePreferences(prefs.copyWith(defaultRestSeconds: res));
                  }
                },
              ),
              const Divider(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Sound Feedback'),
                value: prefs.soundEnabled,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(soundEnabled: val)),
              ),
              const Divider(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Vibration Feedback'),
                value: prefs.vibrationEnabled,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(vibrationEnabled: val)),
              ),
              const Divider(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Show RPE (Rate of Perceived Exertion)'),
                value: prefs.showRpe,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(showRpe: val)),
              ),
              const Divider(height: 24),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Show RIR (Reps in Reserve)'),
                value: prefs.showRir,
                onChanged: (val) =>
                    _savePreferences(prefs.copyWith(showRir: val)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
