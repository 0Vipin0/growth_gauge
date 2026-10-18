// ignore_for_file: use_primary_constructors

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/widgets/responsive_layout.dart';
import '../../application/analytics_cubit.dart';
import '../../domain/analytics_enums.dart';
import '../widgets/pr_badge_card.dart';

/// Screen listing all earned PR trophies and personal achievements.
class const PrTrophyScreen({super.key}) extends StatefulWidget {
  @override
  State<PrTrophyScreen> createState() => _PrTrophyScreenState();
}

class _PrTrophyScreenState extends State<PrTrophyScreen> {
  PrType? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Record Trophies')),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          final prs = _selectedFilter == null
              ? state.personalRecords
              : state.personalRecords
                    .where((p) => p.prType == _selectedFilter)
                    .toList();

          return ResponsiveContent(
            maxWidth: 1100,
            child: Column(
              children: [
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
                Expanded(
                  child: prs.isEmpty
                      ? const Center(
                          child: Text(
                            'No records match the selected filter.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: prs.length,
                          itemBuilder: (context, index) {
                            return PrBadgeCard(record: prs[index]);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
