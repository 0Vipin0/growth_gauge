import 'package:flutter/material.dart';

import '../template/domain/workout_template.dart';
import '../template/infrastructure/template_repository.dart';

enum ActivityTimeRange() {
  week,
  month,
  year,
}

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
    switch (_selectedTimeRange) {
      case ActivityTimeRange.week:
        if (_timeOffset == 0) return 'This Week';
        if (_timeOffset == -1) return 'Last Week';
        return '${_timeOffset.abs()} weeks ago';
      case ActivityTimeRange.month:
        if (_timeOffset == 0) return 'This Month';
        if (_timeOffset == -1) return 'Last Month';
        return '${_timeOffset.abs()} months ago';
      case ActivityTimeRange.year:
        if (_timeOffset == 0) return 'This Year';
        return '${DateTime.now().year + _timeOffset}';
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
                _HubHeader(onProfileTap: widget.onProfileTap),
                const SizedBox(height: 28),
                _WeekSummarySection(isDesktop: isDesktop),
                const SizedBox(height: 32),
                _ActivityTrendsSection(
                  selectedTimeRange: _selectedTimeRange,
                  onAnalyticsTap: widget.onAnalyticsTap,
                  onRangeChanged: (range) => setState(() {
                    _selectedTimeRange = range;
                    _timeOffset = 0;
                  }),
                ),
                const SizedBox(height: 12),
                _ActivityTrendsCard(
                  selectedTimeRange: _selectedTimeRange,
                  timeOffset: _timeOffset,
                  periodLabel: _getPeriodLabel(),
                  onPrevious: () => setState(() => _timeOffset--),
                  onNext: () => setState(() => _timeOffset++),
                ),
                const SizedBox(height: 32),
                _QuickStartSection(
                  templateRepository: widget.templateRepository,
                  onTemplateTap: widget.onTemplateTap,
                  onStartTemplate: widget.onStartTemplate,
                ),
                const SizedBox(height: 32),
                _ExploreBanner(
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

// ---------------------------------------------------------------------------
// _HubHeader
// ---------------------------------------------------------------------------

/// Displays the user's avatar, greeting text, and a notification bell.
class const _HubHeader({final VoidCallback? onProfileTap})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: onProfileTap,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(Icons.person, color: colorScheme.primary),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning,',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'Alex Doe',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.all(12),
          ),
          icon: Badge(
            label: const Text('1'),
            child: Icon(
              Icons.notifications_outlined,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _WeekSummarySection
// ---------------------------------------------------------------------------

/// Shows the "This Week" header plus a responsive grid of stat cards.
class const _WeekSummarySection({required final bool isDesktop})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'This Week',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('Details')),
          ],
        ),
        const SizedBox(height: 12),
        if (isDesktop)
          const _WeekSummaryDesktopGrid()
        else
          const _WeekSummaryMobileStack(),
      ],
    );
  }
}

/// Desktop layout: calories card and stat cards side-by-side with equal height.
class const _WeekSummaryDesktopGrid() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: _CaloriesCard()),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.timer_outlined,
                    title: 'Active Time',
                    value: '5h 20m',
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.fitness_center,
                    title: 'Workouts',
                    value: '4',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Mobile layout: calories card on top, stat cards side-by-side below.
class const _WeekSummaryMobileStack() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _CaloriesCard(),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.timer_outlined,
                title: 'Active Time',
                value: '5h 20m',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.fitness_center,
                title: 'Workouts',
                value: '4',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _CaloriesCard
// ---------------------------------------------------------------------------

/// Card showing total calories burned for the period with a circular progress
/// indicator.
class const _CaloriesCard() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Calories Burned',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '3,240',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              Text(
                'kcal',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 8,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  color: colorScheme.primary,
                  strokeCap: StrokeCap.round,
                ),
              ),
              const Text(
                '85%',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _StatCard
// ---------------------------------------------------------------------------

/// Generic stat tile with an icon, title, and value.
class const _StatCard({
  required final IconData icon,
  required final String title,
  required final String value,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 22),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ActivityTrendsSection
// ---------------------------------------------------------------------------

/// Section header for Activity Trends with the time-range SegmentedButton.
class const _ActivityTrendsSection({
  required final ActivityTimeRange selectedTimeRange,
  required final ValueChanged<ActivityTimeRange> onRangeChanged,
  final VoidCallback? onAnalyticsTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onAnalyticsTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Activity Trends',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          SegmentedButton<ActivityTimeRange>(
            segments: const [
              ButtonSegment(value: ActivityTimeRange.week, label: Text('Week')),
              ButtonSegment(
                value: ActivityTimeRange.month,
                label: Text('Month'),
              ),
              ButtonSegment(value: ActivityTimeRange.year, label: Text('Year')),
            ],
            selected: {selectedTimeRange},
            onSelectionChanged: (newSelection) =>
                onRangeChanged(newSelection.first),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ActivityTrendsCard
// ---------------------------------------------------------------------------

/// Card containing the period navigator (prev/next) and the time-range view.
class const _ActivityTrendsCard({
  required final ActivityTimeRange selectedTimeRange,
  required final int timeOffset,
  required final String periodLabel,
  required final VoidCallback onPrevious,
  required final VoidCallback onNext,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous ${selectedTimeRange.name}',
                onPressed: onPrevious,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    periodLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next ${selectedTimeRange.name}',
                onPressed: onNext,
              ),
            ],
          ),
          const Divider(height: 24),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: switch (selectedTimeRange) {
                ActivityTimeRange.week => const _WeekView(),
                ActivityTimeRange.month => const _MonthView(),
                ActivityTimeRange.year => const _YearView(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WeekView / _MonthView / _YearView
// ---------------------------------------------------------------------------

/// Seven-day bar visualization for the week time range.
class const _WeekView() extends StatelessWidget {
  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const _completed = [true, true, false, true, true, true, false];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final done = _completed[index];
        return Column(
          children: [
            Text(
              _days[index],
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 50,
              decoration: BoxDecoration(
                color: done
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: done
                  ? Icon(Icons.check, size: 20, color: colorScheme.onPrimary)
                  : null,
            ),
          ],
        );
      }),
    );
  }
}

/// Four-week summary for the month time range.
class const _MonthView() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['W1', 'W2', 'W3', 'W4'].map((week) {
        return Column(
          children: [
            Text(
              week,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${4 + week.hashCode % 3} workouts',
                style: TextStyle(color: colorScheme.onSurface, fontSize: 12),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

/// Quarterly summary for the year time range.
class const _YearView() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['Q1', 'Q2', 'Q3', 'Q4'].map((q) {
        return Column(
          children: [
            Text(
              q,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '18 sessions',
                style: TextStyle(color: colorScheme.onSurface, fontSize: 12),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// _QuickStartSection
// ---------------------------------------------------------------------------

/// Section header, FutureBuilder for templates, and responsive grid of cards.
class const _QuickStartSection({
  required final ITemplateRepository templateRepository,
  required final ValueChanged<WorkoutTemplate> onStartTemplate,
  final VoidCallback? onTemplateTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Start',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            TextButton(onPressed: onTemplateTap, child: const Text('See All')),
          ],
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: templateRepository.getTemplates(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final templates = snapshot.hasData && !snapshot.data!.isError
                ? snapshot.data!.dataOrNull ?? []
                : <WorkoutTemplate>[];

            if (templates.isEmpty) {
              return _EmptyTemplatesCard(colorScheme: colorScheme);
            }

            final displayTemplates = templates.take(2).toList();

            return LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = constraints.maxWidth > 700
                    ? (constraints.maxWidth - 16) / 2
                    : constraints.maxWidth;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: displayTemplates.map((template) {
                    return SizedBox(
                      width: cardWidth,
                      child: _QuickStartCard(
                        category: 'WORKOUT',
                        title: template.name,
                        duration: '20 min',
                        calories: '200 kcal',
                        onStart: () => onStartTemplate(template),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

/// Placeholder shown when no templates are available.
class const _EmptyTemplatesCard({required final ColorScheme colorScheme})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text('No templates available.'),
    );
  }
}

// ---------------------------------------------------------------------------
// _QuickStartCard
// ---------------------------------------------------------------------------

/// Individual workout template card with category chip, metadata, and a Start
/// button.
class const _QuickStartCard({
  required final String category,
  required final String title,
  required final String duration,
  required final String calories,
  required final VoidCallback onStart,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                duration,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.local_fire_department,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                calories,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.play_arrow, size: 18),
              label: const Text('Start Workout'),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ExploreBanner
// ---------------------------------------------------------------------------

/// Full-width CTA banner to explore the exercise library / template catalog.
class const _ExploreBanner({
  final VoidCallback? onCatalogTap,
  final VoidCallback? onTemplateTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onCatalogTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(
                        alpha: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'NEW COLLECTION',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Explore Library',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Find your next challenge among hundreds of workouts.',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            IconButton.filled(
              onPressed: onTemplateTap,
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
              ),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
