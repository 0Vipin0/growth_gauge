import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/widgets/widgets.dart';
import '../../application/analytics_cubit.dart';
import '../../domain/analytics_enums.dart';
import '../../domain/personal_record.dart';
import '../widgets/pr_badge_card.dart';

/// Screen listing all earned PR trophies and personal achievements,
/// featuring clear data segregation, multi-filter options, and sorting controls.
class const PrTrophyScreen({super.key}) extends StatefulWidget {
  @override
  State<PrTrophyScreen> createState() => _PrTrophyScreenState();
}

class _PrTrophyScreenState() extends State<PrTrophyScreen> {
  PrType? _selectedFilter;
  String _sortBy = 'date_desc'; // 'date_desc', 'value_desc', 'exercise_asc'

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Personal Record Trophies'),
        centerTitle: true,
      ),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          // 1. Filter records
          final prs = _selectedFilter == null
              ? List<PersonalRecord>.from(state.personalRecords)
              : state.personalRecords
                    .where((p) => p.prType == _selectedFilter)
                    .toList();

          // 2. Sort records
          prs.sort((a, b) {
            if (_sortBy == 'date_desc') {
              return b.achievedAt.compareTo(a.achievedAt);
            } else if (_sortBy == 'value_desc') {
              return b.value.compareTo(a.value);
            } else if (_sortBy == 'exercise_asc') {
              return a.exerciseId.compareTo(b.exerciseId);
            }
            return 0;
          });

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Controls Header: Filters & Sorting Dropdown
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth >= 900 ? 32 : 20,
                        vertical: 12.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Achievements (${prs.length})',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 190,
                            child: AppDropdown<String>(
                              value: _sortBy,
                              items: const [
                                AppDropdownItem(
                                  value: 'date_desc',
                                  label: 'Newest First',
                                  icon: Icons.calendar_today,
                                ),
                                AppDropdownItem(
                                  value: 'value_desc',
                                  label: 'Highest Value',
                                  icon: Icons.trending_up,
                                ),
                                AppDropdownItem(
                                  value: 'exercise_asc',
                                  label: 'Exercise A-Z',
                                  icon: Icons.sort_by_alpha,
                                ),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _sortBy = val);
                                }
                              },
                              label: 'Sort By',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Filter Chips Bar
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth >= 900 ? 32 : 20,
                      ),
                      child: Row(
                        children: [
                          FilterChip(
                            label: const Text('All Trophies'),
                            selected: _selectedFilter == null,
                            onSelected: (_) =>
                                setState(() => _selectedFilter = null),
                          ),
                          const SizedBox(width: 8),
                          ...PrType.values.map((type) {
                            final name = switch (type) {
                              PrType.maxWeight => 'Max Weight',
                              PrType.estimated1Rm => 'Est. 1RM',
                              PrType.maxRepsAtWeight => 'Max Reps',
                              PrType.maxVolumeSet => 'Set Volume',
                              PrType.maxVolumeSession => 'Session Volume',
                            };
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FilterChip(
                                label: Text(name),
                                selected: _selectedFilter == type,
                                onSelected: (_) =>
                                    setState(() => _selectedFilter = type),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Trophies List / Empty State
                    Expanded(
                      child: prs.isEmpty
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth >= 900 ? 32 : 20,
                              ),
                              child: AppCard(
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Center(
                                    child: Text(
                                      'No records match the selected filter.',
                                      style: TextStyle(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth >= 900 ? 32 : 20,
                                vertical: 8,
                              ),
                              itemCount: prs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: PrBadgeCard(record: prs[index]),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
