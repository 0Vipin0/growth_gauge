import 'package:flutter/material.dart';

import '../analytics/domain/daily_workout_summary.dart';
import '../template/domain/workout_template.dart';
import '../template/infrastructure/template_repository.dart';
import 'widgets/activity_trends_section.dart';
import 'widgets/explore_banner.dart';
import 'widgets/hub_header.dart';
import 'widgets/quick_start_section.dart';
import 'widgets/week_summary_section.dart';

// ---------------------------------------------------------------------------
// FitnessHubPage
// ---------------------------------------------------------------------------

/// The main fitness dashboard page.
///
/// Displays a weekly summary, activity trends with time-range navigation,
/// quick-start workout templates, and an explore library banner.
class const FitnessHubPage({
  super.key,
  final VoidCallback? onProfileTap,
  final VoidCallback? onAnalyticsTap,
  final VoidCallback? onCatalogTap,
  final VoidCallback? onTemplateTap,
  required final ITemplateRepository templateRepository,
  required final ValueChanged<WorkoutTemplate> onStartTemplate,
  final List<DailyWorkoutSummary> workoutHistory = const [],
}) extends StatefulWidget {
  @override
  State<FitnessHubPage> createState() => _FitnessHubPageState();
}

class _FitnessHubPageState() extends State<FitnessHubPage> {
  late ActivityTimeRange _selectedTimeRange;
  int _timeOffset = 0;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final screenWidth = MediaQuery.of(context).size.width;
      _selectedTimeRange = screenWidth >= 900
          ? ActivityTimeRange.month
          : ActivityTimeRange.week;
      _initialized = true;
    }
  }

  String _getPeriodLabel() {
    final now = DateTime.now();
    switch (_selectedTimeRange) {
      case ActivityTimeRange.week:
        if (_timeOffset == 0) return 'This Week';
        if (_timeOffset == -1) return 'Last Week';
        return '${_timeOffset.abs()} weeks ago';
      case ActivityTimeRange.month:
        final targetMonth = DateTime(now.year, now.month + _timeOffset);
        const months = [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ];
        return '${months[targetMonth.month - 1]} ${targetMonth.year}';
      case ActivityTimeRange.quarter:
        final currentQuarter = ((now.month - 1) ~/ 3) + 1;
        final targetQuarter = currentQuarter + _timeOffset;
        return 'Q$targetQuarter ${now.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1080),
            child: ListView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 32.0 : 20.0,
                vertical: 24.0,
              ),
              children: [
                HubHeader(onProfileTap: widget.onProfileTap),
                const SizedBox(height: 28),
                WeekSummarySection(
                  isDesktop: isDesktop,
                  summaries: widget.workoutHistory,
                ),
                const SizedBox(height: 32),
                ActivityTrendsSection(
                  selectedTimeRange: _selectedTimeRange,
                  onAnalyticsTap: widget.onAnalyticsTap,
                  onRangeChanged: (range) => setState(() {
                    _selectedTimeRange = range;
                    _timeOffset = 0;
                  }),
                ),
                const SizedBox(height: 12),
                ActivityTrendsCard(
                  selectedTimeRange: _selectedTimeRange,
                  timeOffset: _timeOffset,
                  periodLabel: _getPeriodLabel(),
                  workoutHistory: widget.workoutHistory,
                  onPrevious: () => setState(() => _timeOffset--),
                  onNext: () => setState(() => _timeOffset++),
                ),
                const SizedBox(height: 32),
                QuickStartSection(
                  templateRepository: widget.templateRepository,
                  onTemplateTap: widget.onTemplateTap,
                  onStartTemplate: widget.onStartTemplate,
                ),
                const SizedBox(height: 32),
                ExploreBanner(
                  onCatalogTap: widget.onCatalogTap,
                  onTemplateTap: widget.onTemplateTap,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
