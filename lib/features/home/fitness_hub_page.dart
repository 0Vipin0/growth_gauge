// ignore_for_file: use_primary_constructors

import 'package:flutter/material.dart';

import '../template/domain/workout_template.dart';
import '../template/infrastructure/template_repository.dart';

enum ActivityTimeRange { week, month, year }

class FitnessHubPage extends StatefulWidget {
  const new({
    super.key,
    this.onProfileTap,
    this.onAnalyticsTap,
    this.onCatalogTap,
    this.onTemplateTap,
    required this.templateRepository,
    required this.onStartTemplate,
  });

  final VoidCallback? onProfileTap;
  final VoidCallback? onAnalyticsTap;
  final VoidCallback? onCatalogTap;
  final VoidCallback? onTemplateTap;
  final ITemplateRepository templateRepository;
  final ValueChanged<WorkoutTemplate> onStartTemplate;

  @override
  State<FitnessHubPage> createState() => _FitnessHubPageState();
}

class _FitnessHubPageState extends State<FitnessHubPage> {
  late ActivityTimeRange _selectedTimeRange;
  int _timeOffset =
      0; // 0 = current period, negative = previous, positive = future
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final screenWidth = MediaQuery.of(context).size.width;
      // Default to Week on small screens, Month on large screens
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
                // 1. User Header & Notification Bell
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: widget.onProfileTap,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: colorScheme.primaryContainer,
                            child: Icon(
                              Icons.person,
                              color: colorScheme.primary,
                            ),
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
                ),
                const SizedBox(height: 28),

                // 2. This Week Section Header
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

                // Perfectly Aligned "This Week" Grid using IntrinsicHeight
                if (isDesktop)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(flex: 3, child: _buildCaloriesCard(context)),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(
                                child: _buildStatCard(
                                  context,
                                  icon: Icons.timer_outlined,
                                  title: 'Active Time',
                                  value: '5h 20m',
                                ),
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: _buildStatCard(
                                  context,
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
                  )
                else
                  Column(
                    children: [
                      _buildCaloriesCard(context),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              context,
                              icon: Icons.timer_outlined,
                              title: 'Active Time',
                              value: '5h 20m',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              context,
                              icon: Icons.fitness_center,
                              title: 'Workouts',
                              value: '4',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                const SizedBox(height: 32),

                // 3. Activity Trends Section with View Selector & Paging
                GestureDetector(
                  onTap: widget.onAnalyticsTap,
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
                          ButtonSegment(
                            value: ActivityTimeRange.week,
                            label: Text('Week'),
                          ),
                          ButtonSegment(
                            value: ActivityTimeRange.month,
                            label: Text('Month'),
                          ),
                          ButtonSegment(
                            value: ActivityTimeRange.year,
                            label: Text('Year'),
                          ),
                        ],
                        selected: {_selectedTimeRange},
                        onSelectionChanged: (newSelection) {
                          setState(() {
                            _selectedTimeRange = newSelection.first;
                            _timeOffset = 0;
                          });
                        },
                        style: ButtonStyle(
                          visualDensity: VisualDensity.compact,
                          textStyle: WidgetStateProperty.all(
                            const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildActivityTrendsCard(context, isDesktop),

                const SizedBox(height: 32),

                // 4. Quick Start Section with Dynamic Templates
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
                    TextButton(
                      onPressed: widget.onTemplateTap,
                      child: const Text('See All'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FutureBuilder(
                  future: widget.templateRepository.getTemplates(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data!.isError) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('No templates available.'),
                      );
                    }

                    final templates = snapshot.data!.dataOrNull ?? [];
                    if (templates.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('No templates available.'),
                      );
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
                              child: _buildQuickStartCard(
                                context,
                                category: 'WORKOUT',
                                title: template.name,
                                duration: '20 min',
                                calories: '200 kcal',
                                onStart: () => widget.onStartTemplate(template),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 32),

                // 5. Explore Library Banner
                _buildExploreBanner(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCaloriesCard(BuildContext context) {
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

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
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
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

  Widget _buildActivityTrendsCard(BuildContext context, bool isDesktop) {
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
                tooltip: 'Previous ${_selectedTimeRange.name}',
                onPressed: () => setState(() => _timeOffset--),
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
                    _getPeriodLabel(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next ${_selectedTimeRange.name}',
                onPressed: () => setState(() => _timeOffset++),
              ),
            ],
          ),
          const Divider(height: 24),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: _selectedTimeRange == ActivityTimeRange.week
                  ? _buildWeekView(context)
                  : _selectedTimeRange == ActivityTimeRange.month
                  ? _buildMonthView(context)
                  : _buildYearView(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final completed = [true, true, false, true, true, true, false];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        return Column(
          children: [
            Text(
              days[index],
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
                color: completed[index]
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: completed[index]
                  ? Icon(Icons.check, size: 20, color: colorScheme.onPrimary)
                  : null,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildMonthView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ['W1', 'W2', 'W3', 'W4']
              .map(
                (week) => Column(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${4 + week.hashCode % 3} workouts',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildYearView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final quarters = ['Q1', 'Q2', 'Q3', 'Q4'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: quarters
          .map(
            (q) => Column(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '18 sessions',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildQuickStartCard(
    BuildContext context, {
    required String category,
    required String title,
    required String duration,
    required String calories,
    required VoidCallback onStart,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
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

  Widget _buildExploreBanner(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: widget.onCatalogTap,
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
              onPressed: widget.onTemplateTap,
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
