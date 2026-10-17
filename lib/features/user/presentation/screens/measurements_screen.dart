import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/measurement_cubit.dart';
import '../../domain/user_enums.dart';

class const MeasurementsScreen({super.key}) extends StatelessWidget {
  String _formatType(MeasurementType type) {
    switch (type) {
      case MeasurementType.bodyWeight:
        return 'Body Weight';
      case MeasurementType.bodyFatPercent:
        return 'Body Fat %';
      case MeasurementType.waist:
        return 'Waist';
      case MeasurementType.chest:
        return 'Chest';
      case MeasurementType.arm:
        return 'Arm';
      case MeasurementType.thigh:
        return 'Thigh';
      case MeasurementType.custom:
        return 'Custom';
    }
  }

  String _defaultUnit(MeasurementType type) {
    switch (type) {
      case MeasurementType.bodyWeight:
        return 'kg';
      case MeasurementType.bodyFatPercent:
        return '%';
      case MeasurementType.waist:
      case MeasurementType.chest:
      case MeasurementType.arm:
      case MeasurementType.thigh:
        return 'cm';
      case MeasurementType.custom:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Body Measurements')),
      body: BlocConsumer<MeasurementCubit, MeasurementState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.measurements.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final filtered = state.filteredMeasurements;
          final latest = state.latestMeasurement;

          return Column(
            children: [
              // ── Filter Chips ───────────────────────────────────────────────
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: state.selectedType == null,
                      onSelected: (_) =>
                          context.read<MeasurementCubit>().selectType(null),
                    ),
                    const SizedBox(width: 8),
                    ...MeasurementType.values.map((type) {
                      final isSelected = state.selectedType == type;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(_formatType(type)),
                          selected: isSelected,
                          onSelected: (_) => context
                              .read<MeasurementCubit>()
                              .selectType(isSelected ? null : type),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // ── Latest Stat Card (if selected or available) ─────────────────
              if (latest != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Card(
                    color: theme.colorScheme.primaryContainer.withValues(
                      alpha: 0.4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LATEST ${_formatType(latest.type).toUpperCase()}',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${latest.value.toStringAsFixed(1)} ${latest.unit}',
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            latest.recordedAt.toLocal().toString().split(
                              ' ',
                            )[0],
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // ── Measurements List / Empty State ─────────────────────────────
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.straighten,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No measurements recorded yet',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Log your measurements to track body progress over time.',
                            ),
                            const SizedBox(height: 24),
                            FilledButton.icon(
                              onPressed: () =>
                                  _showLogDialog(context, state.selectedType),
                              icon: const Icon(Icons.add),
                              label: const Text('Log Measurement'),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final item = filtered[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: theme.colorScheme.primary
                                  .withValues(alpha: 0.1),
                              child: Icon(
                                Icons.straighten,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              '${item.value.toStringAsFixed(1)} ${item.unit}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${_formatType(item.type)}${item.notes != null && item.notes!.isNotEmpty ? ' • ${item.notes}' : ''}',
                            ),
                            trailing: Text(
                              item.recordedAt.toLocal().toString().split(
                                ' ',
                              )[0],
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<MeasurementCubit>();
          _showLogDialog(context, cubit.state.selectedType);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showLogDialog(BuildContext context, MeasurementType? defaultType) {
    final formKey = GlobalKey<FormState>();
    final valueController = TextEditingController();
    final unitController = TextEditingController(
      text: _defaultUnit(defaultType ?? MeasurementType.bodyWeight),
    );
    final notesController = TextEditingController();
    MeasurementType selectedType = defaultType ?? MeasurementType.bodyWeight;
    DateTime selectedDate = DateTime.now();

    showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (dialogCtx, setState) {
            return AlertDialog(
              title: const Text('Log Measurement'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButtonFormField<MeasurementType>(
                        initialValue: selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Measurement Type',
                        ),
                        items: MeasurementType.values.map((t) {
                          return DropdownMenuItem(
                            value: t,
                            child: Text(_formatType(t)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              selectedType = val;
                              unitController.text = _defaultUnit(val);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: valueController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                labelText: 'Value *',
                              ),
                              validator: (v) => double.tryParse(v ?? '') == null
                                  ? 'Enter a valid number'
                                  : null,
                              autofocus: true,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 80,
                            child: TextFormField(
                              controller: unitController,
                              decoration: const InputDecoration(
                                labelText: 'Unit',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: dialogCtx,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now().add(
                                const Duration(days: 1),
                              ),
                            );
                            if (picked != null) {
                              setState(() => selectedDate = picked);
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notes (optional)',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogCtx).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final val = double.parse(valueController.text);
                      context.read<MeasurementCubit>().logMeasurement(
                        type: selectedType,
                        value: val,
                        unit: unitController.text.trim().isEmpty
                            ? _defaultUnit(selectedType)
                            : unitController.text.trim(),
                        recordedAt: selectedDate,
                        notes: notesController.text.trim().isEmpty
                            ? null
                            : notesController.text.trim(),
                      );
                      Navigator.of(dialogCtx).pop();
                    }
                  },
                  child: const Text('Log'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
