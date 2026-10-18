import 'package:flutter/material.dart';

import '../../../../core/units/unit_types.dart';
import '../../../common/presentation/widgets/responsive_layout.dart';
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

  @override
  void initState() {
    super.initState();
    _loadData();
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
    final profile = _profile!;
    final training = _trainingProfile!;
    final prefs = _preferences!;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Preferences')),
      body: ResponsiveContent(
        maxWidth: 1000,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // ── Header Card ──────────────────────────────────────────────────
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: theme.colorScheme.primary.withValues(
                        alpha: 0.2,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 36,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.displayName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${training.trainingExperience.name.toUpperCase()} • ${training.primaryTrainingStyle}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ── Unit Preferences ─────────────────────────────────────────────
            Text(
              'Unit Preferences',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Weight Unit'),
                        const SizedBox(height: 8),
                        SegmentedButton<WeightUnit>(
                          segments: const [
                            ButtonSegment(
                              value: WeightUnit.kilograms,
                              label: Text('KG'),
                            ),
                            ButtonSegment(
                              value: WeightUnit.pounds,
                              label: Text('LB'),
                            ),
                          ],
                          selected: {profile.weightUnit},
                          onSelectionChanged: (set) => _saveProfile(
                            profile.copyWith(weightUnit: set.first),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Distance Unit'),
                        const SizedBox(height: 8),
                        SegmentedButton<DistanceUnit>(
                          segments: const [
                            ButtonSegment(
                              value: DistanceUnit.kilometers,
                              label: Text('KM'),
                            ),
                            ButtonSegment(
                              value: DistanceUnit.miles,
                              label: Text('MI'),
                            ),
                          ],
                          selected: {profile.distanceUnit},
                          onSelectionChanged: (set) => _saveProfile(
                            profile.copyWith(distanceUnit: set.first),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Height Unit'),
                        const SizedBox(height: 8),
                        SegmentedButton<HeightUnit>(
                          segments: const [
                            ButtonSegment(
                              value: HeightUnit.centimeters,
                              label: Text('CM'),
                            ),
                            ButtonSegment(
                              value: HeightUnit.feetAndInches,
                              label: Text('FT/IN'),
                            ),
                          ],
                          selected: {profile.heightUnit},
                          onSelectionChanged: (set) => _saveProfile(
                            profile.copyWith(heightUnit: set.first),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Training Profile ─────────────────────────────────────────────
            Text(
              'Training Profile',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Experience Level'),
                    trailing: DropdownButton<TrainingExperience>(
                      value: training.trainingExperience,
                      underline: const SizedBox.shrink(),
                      items: TrainingExperience.values.map((exp) {
                        return DropdownMenuItem(
                          value: exp,
                          child: Text(exp.name.toUpperCase()),
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
                  ),
                  const Divider(height: 1),
                  ListTile(
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
            const SizedBox(height: 16),

            // ── Workout Preferences ──────────────────────────────────────────
            Text(
              'Workout Execution Preferences',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Auto-start Rest Timer'),
                    subtitle: const Text(
                      'Starts rest timer immediately on set log',
                    ),
                    value: prefs.autoStartRestTimer,
                    onChanged: (val) => _savePreferences(
                      prefs.copyWith(autoStartRestTimer: val),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Default Rest Duration'),
                    trailing: Text('${prefs.defaultRestSeconds}s'),
                    onTap: () async {
                      int seconds = prefs.defaultRestSeconds;
                      final res = await showDialog<int>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Default Rest (Seconds)'),
                          content: TextFormField(
                            initialValue: seconds.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) =>
                                seconds = int.tryParse(v) ?? seconds,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(seconds),
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      );
                      if (res != null) {
                        _savePreferences(
                          prefs.copyWith(defaultRestSeconds: res),
                        );
                      }
                    },
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Sound Feedback'),
                    value: prefs.soundEnabled,
                    onChanged: (val) =>
                        _savePreferences(prefs.copyWith(soundEnabled: val)),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Vibration Feedback'),
                    value: prefs.vibrationEnabled,
                    onChanged: (val) =>
                        _savePreferences(prefs.copyWith(vibrationEnabled: val)),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Show RPE (Rate of Perceived Exertion)'),
                    value: prefs.showRpe,
                    onChanged: (val) =>
                        _savePreferences(prefs.copyWith(showRpe: val)),
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    title: const Text('Show RIR (Reps in Reserve)'),
                    value: prefs.showRir,
                    onChanged: (val) =>
                        _savePreferences(prefs.copyWith(showRir: val)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
