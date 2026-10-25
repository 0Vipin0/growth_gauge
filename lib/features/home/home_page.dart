import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';
import '../catalog/infrastructure/exercise_repository.dart';
import '../common/presentation/widgets/responsive_layout.dart';
import '../session/application/session_use_cases.dart';
import '../session/domain/session_enums.dart';
import '../session/infrastructure/session_repository.dart';
import '../session/presentation/active_session_screen.dart';
import '../session/presentation/session_recovery_dialog.dart';
import '../settings/settings_page.dart';
import '../template/template.dart';
import 'fitness_hub_page.dart';

// ---------------------------------------------------------------------------
// HomePage
// ---------------------------------------------------------------------------

/// Root scaffold that hosts the application's primary navigation destinations
/// (Training hub and Settings) via a responsive [NavigationRail] on medium/large
/// screens or a [BottomNavigationBar] on compact screens.
///
/// On mount it checks for unfinished sessions and offers session recovery via
/// [SessionRecoveryDialog].
class const HomePage({
  super.key,
  required final IWorkoutSessionRepository sessionRepository,
  required final SessionUseCases sessionUseCases,
  required final IExerciseRepository exerciseRepository,
  required final ITemplateRepository templateRepository,
  final String userId = 'local-user',
}) extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState() extends State<HomePage> {
  int _selectedIndex = 0;
  bool? _railExtendedOverride;
  final PageController _pageController = PageController();

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _offerRecovery());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Session recovery
  // ---------------------------------------------------------------------------

  Future<void> _offerRecovery() async {
    final result = await widget.sessionRepository.listUnfinished(widget.userId);
    if (!mounted || result.isError || result.dataOrNull!.isEmpty) return;

    final selected = await showSessionRecoveryDialog(
      context,
      result.dataOrNull!,
    );
    if (selected == null || !mounted) return;

    final recovery = await widget.sessionUseCases.recoverIncomplete(
      selected.id,
    );
    if (!mounted) return;

    if (recovery.isError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(recovery.errorOrNull!.message)));
      return;
    }

    final session = recovery.dataOrNull!;
    if (session.status == SessionStatus.completed) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ActiveSessionScreen(
          session: session,
          useCases: widget.sessionUseCases,
          exerciseRepository: widget.exerciseRepository,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Template → session start
  // ---------------------------------------------------------------------------

  /// Resolves the latest published revision for [template], creates and starts
  /// a session, then navigates to [ActiveSessionScreen].
  Future<void> _startTemplate(WorkoutTemplate template) async {
    final revisionsResult = await widget.templateRepository.getRevisions(
      template.id,
    );
    if (!mounted) return;

    if (revisionsResult.isError || revisionsResult.dataOrNull!.isEmpty) {
      _showError('No revisions found for this template');
      return;
    }

    final published =
        revisionsResult.dataOrNull!
            .where((r) => r.status.name == 'published')
            .toList()
          ..sort((a, b) => b.revisionNumber.compareTo(a.revisionNumber));

    if (published.isEmpty) {
      _showError('No published revision found for this template');
      return;
    }

    final createResult = await widget.sessionUseCases.createFromRevision(
      revisionId: published.first.id,
      userId: widget.userId,
    );
    if (!mounted) return;
    if (createResult.isError) {
      _showError(createResult.errorOrNull!.message);
      return;
    }

    final startResult = await widget.sessionUseCases.start(
      createResult.dataOrNull!.id,
    );
    if (!mounted) return;
    if (startResult.isError) {
      _showError(startResult.errorOrNull!.message);
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ActiveSessionScreen(
          session: startResult.dataOrNull!,
          useCases: widget.sessionUseCases,
          exerciseRepository: widget.exerciseRepository,
        ),
      ),
    );
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  void _selectDestination(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 300),
      curve: MediaQuery.disableAnimationsOf(context)
          ? Curves.linear
          : Curves.easeInOut,
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sizeClass = AppWindowSizeClass.fromWidth(constraints.maxWidth);
        final isCompact = sizeClass == AppWindowSizeClass.compact;
        final railExtended =
            _railExtendedOverride ?? sizeClass == AppWindowSizeClass.expanded;

        return FocusTraversalGroup(
          child: Scaffold(
            body: Row(
              children: [
                if (!isCompact) ...[
                  _AppNavigationRail(
                    selectedIndex: _selectedIndex,
                    extended: railExtended,
                    onDestinationSelected: _selectDestination,
                    onToggleExtended: () =>
                        setState(() => _railExtendedOverride = !railExtended),
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                ],
                Expanded(
                  child: _DestinationPageView(
                    controller: _pageController,
                    onPageChanged: (i) => setState(() => _selectedIndex = i),
                    fitnessHubPage: FitnessHubPage(
                      templateRepository: widget.templateRepository,
                      onStartTemplate: _startTemplate,
                      onProfileTap: () => context.push(appRouteProfile),
                      onAnalyticsTap: () => context.push(appRouteAnalytics),
                      onCatalogTap: () => context.push(appRouteExerciseCatalog),
                      onTemplateTap: () =>
                          context.push(appRouteWorkoutTemplates),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: isCompact
                ? _AppBottomNavigationBar(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _selectDestination,
                  )
                : null,
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Private sub-widgets
// ---------------------------------------------------------------------------

/// Responsive navigation rail shown on medium and expanded layouts.
class const _AppNavigationRail({
    required final int selectedIndex,
    required final bool extended,
    required final ValueChanged<int> onDestinationSelected,
    required final VoidCallback onToggleExtended,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return NavigationRail(
      selectedIndex: selectedIndex,
      extended: extended,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.fitness_center),
          label: Text('Training'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
      ],
      leading: IconButton(
        tooltip: extended ? 'Collapse' : 'Expand',
        icon: Icon(extended ? Icons.chevron_left : Icons.chevron_right),
        onPressed: onToggleExtended,
      ),
      selectedIconTheme: IconThemeData(color: colorScheme.primary),
      selectedLabelTextStyle: TextStyle(color: colorScheme.primary),
      unselectedIconTheme: IconThemeData(color: colorScheme.primaryFixedDim),
      unselectedLabelTextStyle: TextStyle(color: colorScheme.primaryFixedDim),
    );
  }
}

/// Bottom navigation bar shown on compact (mobile) layouts.
class const _AppBottomNavigationBar({
    required final int selectedIndex,
    required final ValueChanged<int> onDestinationSelected,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Training',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      selectedIconTheme: IconThemeData(color: colorScheme.primary),
      unselectedIconTheme: IconThemeData(color: colorScheme.primaryFixedDim),
    );
  }
}

/// [PageView] hosting the two top-level destinations.
class const _DestinationPageView({
    required final PageController controller,
    required final ValueChanged<int> onPageChanged,
    required final Widget fitnessHubPage,
  }) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      key: const PageStorageKey<String>('home-destinations'),
      controller: controller,
      onPageChanged: onPageChanged,
      children: [fitnessHubPage, const SettingsPage()],
    );
  }
}
