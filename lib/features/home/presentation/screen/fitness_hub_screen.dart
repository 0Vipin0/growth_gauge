import 'package:flutter/material.dart';

import '../../../analytics/domain/daily_workout_summary.dart';
import '../../../template/domain/workout_template.dart';
import '../../../template/infrastructure/template_repository.dart';
import '../../../user/user.dart';
import '../widgets/activity_trends_section.dart';
import '../widgets/explore_banner.dart';
import '../widgets/hub_header.dart';
import '../widgets/quick_start_section.dart';
import '../widgets/week_summary_section.dart';

class const FitnessHubScreen({
    super.key,
    required final UserUseCases useCases,
    final String userId = 'local-user',
    final VoidCallback? onProfileTap,
    final VoidCallback? onAnalyticsTap,
    final VoidCallback? onCatalogTap,
    final VoidCallback? onTemplateTap,
    required final ITemplateRepository templateRepository,
    required final ValueChanged<WorkoutTemplate> onStartTemplate,
    final List<DailyWorkoutSummary> workoutHistory = const [],
  }) extends StatefulWidget {
  @override
  State<FitnessHubScreen> createState() => _FitnessHubScreenState();
}

class _FitnessHubScreenState() extends State<FitnessHubScreen> {
  UserProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final result = await widget.useCases.getOrCreateProfile(widget.userId);
    if (mounted) {
      setState(() {
        _profile = result.dataOrNull;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 900;

    final profileName = _profile?.displayName.trim();
    final userName = (profileName != null && profileName.isNotEmpty)
        ? profileName
        : 'Athlete';

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
                vertical: isDesktop ? 32.0 : 24.0,
              ),
              children: [
                HubHeader(
                  userName: userName,
                  onProfileTap: widget.onProfileTap,
                  isDesktop: isDesktop,
                ),
                SizedBox(height: isDesktop ? 36 : 28),
                WeekSummarySection(
                  isDesktop: isDesktop,
                  summaries: widget.workoutHistory,
                  onDetailsTap: widget.onAnalyticsTap,
                ),
                SizedBox(height: isDesktop ? 36 : 32),
                ActivityTrendsCard(
                  workoutHistory: widget.workoutHistory,
                  onAnalyticsTap: widget.onAnalyticsTap,
                  isDesktop: isDesktop,
                ),
                SizedBox(height: isDesktop ? 36 : 32),
                QuickStartSection(
                  templateRepository: widget.templateRepository,
                  onTemplateTap: widget.onTemplateTap,
                  onStartTemplate: widget.onStartTemplate,
                ),
                SizedBox(height: isDesktop ? 36 : 32),
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
