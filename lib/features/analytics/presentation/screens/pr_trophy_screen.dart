import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/analytics_cubit.dart';
import '../../domain/analytics_enums.dart';
import '../widgets/pr_badge_card.dart';

/// Screen listing all earned PR trophies and personal achievements,
/// optimized for small, medium, and large screens with responsive constraints.
class const PrTrophyScreen({super.key}) extends StatefulWidget {
  @override
  State<PrTrophyScreen> createState() => _PrTrophyScreenState();
}

class _PrTrophyScreenState() extends State<PrTrophyScreen> {
  PrType? _selectedFilter;

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
          final prs = _selectedFilter == null
              ? state.personalRecords
              : state.personalRecords
                    .where((p) => p.prType == _selectedFilter)
                    .toList();

          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  children: [
                    // Filter Chips Bar
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth >= 900 ? 32 : 20,
                        vertical: 12.0,
                      ),
                      child: Row(
                        children: [
                          FilterChip(
                            label: const Text('All'),
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

                    // Trophies List / Empty State
                    Expanded(
                      child: prs.isEmpty
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth >= 900 ? 32 : 20,
                              ),
                              child: Card(
                                elevation: 0,
                                color: colorScheme.surfaceContainer,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Center(
                                    child: Text(
                                      'No records match the selected filter.',
                                      style: TextStyle(color: Colors.grey),
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
